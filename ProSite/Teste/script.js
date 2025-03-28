// Alternar entre modo claro e escuro
document.querySelector('.theme-toggle').addEventListener('click', () => {
    document.body.classList.toggle('dark-mode');

    // Alterar o ícone do botão
    const themeToggle = document.querySelector('.theme-toggle');
    if (document.body.classList.contains('dark-mode')) {
        themeToggle.textContent = '☀️';
    } else {
        themeToggle.textContent = '🌙';
    }
});
