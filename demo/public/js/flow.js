let scale = 1;
let translateX = 0;
let translateY = 0;
let isDragging = false;
let dragNode = null;
let dragOffset = { x: 0, y: 0 };

function createSvgElement(type, attributes = {}) {
  const element = document.createElementNS('http://www.w3.org/2000/svg', type);
  Object.entries(attributes).forEach(([key, value]) => {
    element.setAttribute(key, value);
  });
  return element;
}

function initializeSvg() {
  const container = document.getElementById('flow-root');
  
  // Create SVG container
  const svg = createSvgElement('svg', {
    id: 'flow-container',
    width: '100%',
    height: '100%'
  });

  // Create defs
  const defs = createSvgElement('defs');
  
  // Create grid pattern
  const pattern = createSvgElement('pattern', {
    id: 'grid',
    width: '20',
    height: '20',
    patternUnits: 'userSpaceOnUse'
  });
  
  const circle = createSvgElement('circle', {
    cx: '1',
    cy: '1',
    r: '1',
    fill: '#CCCCCC'
  });
  
  // Create arrow marker
  const marker = createSvgElement('marker', {
    id: 'arrowhead',
    markerWidth: '10',
    markerHeight: '7',
    refX: '9',
    refY: '3.5',
    orient: 'auto'
  });
  
  const polygon = createSvgElement('polygon', {
    points: '0 0, 10 3.5, 0 7',
    fill: '#555'
  });

  // Create background rect
  const backgroundRect = createSvgElement('rect', {
    x: '-50000',
    y: '-50000',
    width: '100000',
    height: '100000',
    fill: 'url(#grid)',
    'pointer-events': 'none'
  });

  // Create groups for edges and nodes
  const edgesGroup = createSvgElement('g', { id: 'edges' });
  const nodesGroup = createSvgElement('g', { id: 'nodes' });
  const transformGroup = createSvgElement('g', { id: 'transform-group' });

  // Assemble SVG structure
  marker.appendChild(polygon);
  pattern.appendChild(circle);
  defs.appendChild(pattern);
  defs.appendChild(marker);
  svg.appendChild(defs);
  transformGroup.appendChild(backgroundRect);
  transformGroup.appendChild(edgesGroup);
  transformGroup.appendChild(nodesGroup);
  svg.appendChild(transformGroup);
  
  // Create controls
  const controls = document.createElement('div');
  controls.className = 'controls';
  controls.innerHTML = `
    <button onclick="zoomIn()">+</button>
    <button onclick="zoomOut()">-</button>
    <button onclick="resetView()">Reset</button>
  `;

  // Add everything to container
  container.appendChild(svg);
  container.appendChild(controls);

  // Add pan event listener
  svg.addEventListener('mousedown', (e) => {
    if (e.target.tagName === 'svg') {
      isPanning = true;
      panStart = { x: e.clientX - translateX, y: e.clientY - translateY };
    }
  });

  return svg;
}

document.addEventListener('DOMContentLoaded', () => {
  initializeSvg();
  renderGraph();
});

function getHandlesByPosition(handles, position) {
  return handles.filter(h => h.position === position);
}

function calculateHandlePosition(nodePosition, handlePosition, handleIndex, totalHandles) {
  const NODE_WIDTH = 150;
  const NODE_HEIGHT = 60;
  const HANDLE_SPACING = 20; // minimum space between handles
  
  // Calculate total width needed for handles
  const totalWidth = (totalHandles - 1) * HANDLE_SPACING;
  
  // For single handle, position in center
  if (totalHandles === 1) {
    switch (handlePosition) {
      case 'bottom':
        return { x: nodePosition.x + NODE_WIDTH/2, y: nodePosition.y + NODE_HEIGHT };
      case 'top':
        return { x: nodePosition.x + NODE_WIDTH/2, y: nodePosition.y };
      case 'left':
        return { x: nodePosition.x, y: nodePosition.y + NODE_HEIGHT/2 };
      case 'right':
        return { x: nodePosition.x + NODE_WIDTH, y: nodePosition.y + NODE_HEIGHT/2 };
    }
  }
  
  // For multiple handles, distribute evenly
  switch (handlePosition) {
    case 'bottom':
    case 'top': {
      const y = handlePosition === 'bottom' ? nodePosition.y + NODE_HEIGHT : nodePosition.y;
      const startX = nodePosition.x + (NODE_WIDTH - totalWidth) / 2;
      return { x: startX + (handleIndex * HANDLE_SPACING), y };
    }
    case 'left':
    case 'right': {
      const x = handlePosition === 'right' ? nodePosition.x + NODE_WIDTH : nodePosition.x;
      const startY = nodePosition.y + (NODE_HEIGHT - totalWidth) / 2;
      return { x, y: startY + (handleIndex * HANDLE_SPACING) };
    }
  }
}

function getHandlePosition(node, handleId) {
  const allHandles = [...(node.source_handles || []), ...(node.target_handles || [])];
  const handle = allHandles.find(h => h.id === handleId);
  
  if (!handle) return null;

  const handlesOnSameSide = getHandlesByPosition(allHandles, handle.position);
  const handleIndex = handlesOnSameSide.findIndex(h => h.id === handleId);
  
  return calculateHandlePosition(
    node.position,
    handle.position,
    handleIndex,
    handlesOnSameSide.length
  );
}

function renderGraph() {
  const nodesContainer = document.getElementById('nodes');
  const edgesContainer = document.getElementById('edges');
  
  // Clear existing elements
  nodesContainer.innerHTML = '';
  edgesContainer.innerHTML = '';

  // Render edges
  edges.forEach(edge => {
    const sourceNode = nodes.find(n => n.id === edge.source);
    const targetNode = nodes.find(n => n.id === edge.target);
    
    if (sourceNode && targetNode) {
      const sourcePos = getHandlePosition(sourceNode, edge.source_handle);
      const targetPos = getHandlePosition(targetNode, edge.target_handle);
      
      if (sourcePos && targetPos) {
        const line = createSvgElement('line', {
          class: 'edge',
          x1: sourcePos.x,
          y1: sourcePos.y,
          x2: targetPos.x,
          y2: targetPos.y
        });
        edgesContainer.appendChild(line);
      }
    }
  });

  // Render nodes
  nodes.forEach(node => {
    const g = createSvgElement('g', {
      transform: `translate(${node.position.x},${node.position.y})`,
      'data-id': node.id
    });

    const rect = createSvgElement('rect', {
      class: 'node',
      width: '150',
      height: '60',
      rx: '5'
    });

    const text = createSvgElement('text', {
      class: 'node-label',
      x: '75',
      y: '30'
    });
    text.textContent = node.data.label;

    g.appendChild(rect);
    g.appendChild(text);

    // Get all handles grouped by position
    const allHandles = [...(node.source_handles || []), ...(node.target_handles || [])];
    const handlesByPosition = {
      top: getHandlesByPosition(allHandles, 'top'),
      bottom: getHandlesByPosition(allHandles, 'bottom'),
      left: getHandlesByPosition(allHandles, 'left'),
      right: getHandlesByPosition(allHandles, 'right')
    };

    // Render all handles
    Object.entries(handlesByPosition).forEach(([position, handles]) => {
      handles.forEach((handle, index) => {
        const pos = calculateHandlePosition(
          { x: 0, y: 0 }, // Use relative coordinates since we're in the group
          position,
          index,
          handles.length
        );

        const handleElement = createSvgElement('circle', {
          class: `handle ${handle.type}-handle`,
          r: '4',
          cx: pos.x,
          cy: pos.y,
          'data-handle-id': handle.id,
          'data-handle-type': handle.type,
          'data-handle-position': handle.position
        });

        g.appendChild(handleElement);
      });
    });
    
    // Add drag handlers
    g.addEventListener('mousedown', startDrag);
    nodesContainer.appendChild(g);
  });

  updateTransform();
}

function startDrag(e) {
  if (e.target.classList.contains('node')) {
    isDragging = true;
    dragNode = e.currentTarget;
    const nodeId = dragNode.getAttribute('data-id');
    const node = nodes.find(n => n.id === nodeId);
    
    dragOffset.x = e.clientX - node.position.x;
    dragOffset.y = e.clientY - node.position.y;
    
    document.addEventListener('mousemove', drag);
    document.addEventListener('mouseup', stopDrag);
  }
}

function drag(e) {
  if (isDragging && dragNode) {
    const nodeId = dragNode.getAttribute('data-id');
    const node = nodes.find(n => n.id === nodeId);
    
    node.position.x = e.clientX - dragOffset.x;
    node.position.y = e.clientY - dragOffset.y;
    
    renderGraph();
  }
}

function stopDrag() {
  isDragging = false;
  dragNode = null;
  document.removeEventListener('mousemove', drag);
  document.removeEventListener('mouseup', stopDrag);
}

function updateTransform() {
  const container = document.getElementById('flow-container');
  const transformGroup = container.querySelector('g#transform-group');
  transformGroup.setAttribute('transform', 
    `translate(${translateX},${translateY}) scale(${scale})`);
}

function zoomIn() {
  scale *= 1.2;
  updateTransform();
}

function zoomOut() {
  scale *= 0.8;
  updateTransform();
}

function resetView() {
  scale = 1;
  translateX = 0;
  translateY = 0;
  updateTransform();
}

// Pan functionality
let isPanning = false;
let panStart = { x: 0, y: 0 };

document.addEventListener('DOMContentLoaded', () => {
  document.getElementById('flow-container').addEventListener('mousedown', (e) => {
    if (e.target.tagName === 'svg') {
      isPanning = true;
      panStart = { x: e.clientX - translateX, y: e.clientY - translateY };
    }
  });

  document.addEventListener('mousemove', (e) => {
    if (isPanning) {
      translateX = e.clientX - panStart.x;
      translateY = e.clientY - panStart.y;
      updateTransform();
    }
  });

  document.addEventListener('mouseup', () => {
    isPanning = false;
  });
}); 