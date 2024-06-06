let tasks = [];

document.getElementById('task-form').addEventListener('submit', function(e) {
    e.preventDefault();
    const taskName = document.getElementById('task-name').value;
    const assignedTo = document.getElementById('assigned-to').value;
    addTask(taskName, assignedTo);
    this.reset();
});

function addTask(name, assignedTo) {
    const task = {
        id: Date.now(),
        name,
        assignedTo
    };
    tasks.push(task);
    renderTasks();
}

function deleteTask(id) {
    tasks = tasks.filter(task => task.id !== id);
    renderTasks();
}

function editTask(id) {
    const task = tasks.find(task => task.id === id);
    const newTaskName = prompt("Edit task name:", task.name);
    const newAssignedTo = prompt("Edit assigned to:", task.assignedTo);
    if (newTaskName && newAssignedTo) {
        task.name = newTaskName;
        task.assignedTo = newAssignedTo;
        renderTasks();
    }
}

function renderTasks() {
    const taskList = document.getElementById('tasks');
    taskList.innerHTML = '';
    tasks.forEach(task => {
        const li = document.createElement('li');
        li.className = 'task-item';
        li.innerHTML = `
            ${task.name} (Assigned to: ${task.assignedTo})
            <div>
                <button onclick="editTask(${task.id})">Edit</button>
                <button onclick="deleteTask(${task.id})">Delete</button>
            </div>
        `;
        taskList.appendChild(li);
    });
}

renderTasks();
