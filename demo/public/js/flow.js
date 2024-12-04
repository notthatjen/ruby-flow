let scale = 1;
let translateX = 0;
let translateY = 0;
let isDragging = false;
let dragNode = null;
let dragOffset = { x: 0, y: 0 };

document.addEventListener('DOMContentLoaded', () => {
  renderGraph();
});

function renderGraph() {
  const svg = document.getElementById('flow-container');
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
      const line = document.createElementNS('http://www.w3.org/2000/svg', 'line');
      line.setAttribute('class', 'edge');
      line.setAttribute('x1', sourceNode.position.x + 75);
      line.setAttribute('y1', sourceNode.position.y + 30);
      line.setAttribute('x2', targetNode.position.x + 75);
      line.setAttribute('y2', targetNode.position.y + 30);
      edgesContainer.appendChild(line);
    }
  });

  // Render nodes
  nodes.forEach(node => {
    const g = document.createElementNS('http://www.w3.org/2000/svg', 'g');
    g.setAttribute('transform', `translate(${node.position.x},${node.position.y})`);
    g.setAttribute('data-id', node.id);

    const rect = document.createElementNS('http://www.w3.org/2000/svg', 'rect');
    rect.setAttribute('class', 'node');
    rect.setAttribute('width', '150');
    rect.setAttribute('height', '60');
    rect.setAttribute('rx', '5');

    const text = document.createElementNS('http://www.w3.org/2000/svg', 'text');
    text.setAttribute('class', 'node-label');
    text.setAttribute('x', '75');
    text.setAttribute('y', '30');
    text.textContent = node.data.label;

    g.appendChild(rect);
    g.appendChild(text);
    
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
  const transform = container.querySelector('g#nodes');
  transform.setAttribute('transform', 
    `translate(${translateX},${translateY}) scale(${scale})`);
  
  const edgesTransform = container.querySelector('g#edges');
  edgesTransform.setAttribute('transform', 
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