const toggleButton = document.getElementById('toggle-mode');
toggleButton.addEventListener('click', () => {
    document.body.classList.toggle('dark-mode');

    if (document.body.classList.contains('dark-mode')) {
        toggleButton.textContent = "☀️";
    } else {
        toggleButton.textContent = "🌙";
    }
});

// Simula ação de cadastro
document.querySelector('.btn-cadastro').addEventListener('click', () => {
    alert('Página de cadastro em desenvolvimento!');
});