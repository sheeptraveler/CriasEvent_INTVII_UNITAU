const toggleButton = document.getElementById('toggle-mode');
const htmlElement = document.documentElement; // Melhor alternar no html

toggleButton.addEventListener('click', () => {
    htmlElement.classList.toggle('dark-mode');
    
    // Salva a preferência no localStorage
    const isDarkMode = htmlElement.classList.contains('dark-mode');
    localStorage.setItem('darkMode', isDarkMode);
    
    // Atualiza o ícone
    toggleButton.textContent = isDarkMode ? "☀️" : "🌙";
});

// Verifica preferência salva ao carregar a página
if (localStorage.getItem('darkMode') === 'true') {
    htmlElement.classList.add('dark-mode');
    toggleButton.textContent = "☀️";
} else {
    toggleButton.textContent = "🌙";

};

