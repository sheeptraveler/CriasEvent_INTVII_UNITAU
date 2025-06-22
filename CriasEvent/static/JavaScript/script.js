// script.js - Código completo para todas as páginas

// ============ MODO ESCURO ============
const toggleButton = document.getElementById('toggle-mode');
const htmlElement = document.documentElement;

// Verifica preferência salva ao carregar
if (localStorage.getItem('darkMode') === 'true') {
    htmlElement.classList.add('dark-mode');
    if (toggleButton) toggleButton.textContent = "☀️";
}

// Configura o evento de clique
if (toggleButton) {
    toggleButton.addEventListener('click', () => {
        htmlElement.classList.toggle('dark-mode');
        const isDarkMode = htmlElement.classList.contains('dark-mode');
        localStorage.setItem('darkMode', isDarkMode);
        toggleButton.textContent = isDarkMode ? "☀️" : "🌙";
    });
}

// ============ SLIDER DO BANNER (para index.html) ============
if (document.querySelector('.banner')) {
    let currentSlide = 0;
    const slides = document.querySelectorAll('.slide');
    const totalSlides = slides.length;

    function showSlide(n) {
        slides.forEach(slide => slide.classList.remove('active'));
        currentSlide = (n + totalSlides) % totalSlides;
        slides[currentSlide].classList.add('active');
    }

    // Navegação manual
    document.querySelector('.banner-prev')?.addEventListener('click', () => {
        showSlide(currentSlide - 1);
    });

    document.querySelector('.banner-next')?.addEventListener('click', () => {
        showSlide(currentSlide + 1);
    });

    // Auto-avanço (opcional)
    //setInterval(() => {
    //    showSlide(currentSlide + 1);
    //}, 5000);
}

// ============ FILTROS DE EVENTOS (para eventos.html) ============
document.addEventListener('DOMContentLoaded', function() {
    const filterButtons = document.querySelectorAll('.filter-btn');
    const eventCards = document.querySelectorAll('.card');

    filterButtons.forEach(button => {
        button.addEventListener('click', function() {
            // Remove a classe 'active' de todos os botões
            filterButtons.forEach(btn => btn.classList.remove('active'));
            
            // Adiciona a classe 'active' apenas ao botão clicado
            this.classList.add('active');
            
            const filterValue = this.getAttribute('data-category');
            
            // Filtra os eventos
            eventCards.forEach(card => {
                const cardCategories = card.getAttribute('data-categories');
                
                if (filterValue === 'all' || cardCategories.includes(filterValue)) {
                    card.style.display = 'block';
                    setTimeout(() => {
                        card.style.opacity = '1';
                        card.style.transform = 'translateY(0)';
                    }, 50);
                } else {
                    card.style.opacity = '0';
                    card.style.transform = 'translateY(20px)';
                    setTimeout(() => {
                        card.style.display = 'none';
                    }, 300);
                }
            });
        });
    });
});


// ============ PAGINAÇÃO (para eventos.html) ============
if (document.querySelector('.page-btn')) {
    document.querySelectorAll('.page-btn').forEach(btn => {
        btn.addEventListener('click', function() {
            if (!this.classList.contains('next')) {
                document.querySelectorAll('.page-btn').forEach(b => b.classList.remove('active'));
                this.classList.add('active');
            }
            // Aqui você implementaria a lógica para carregar mais eventos
            console.log('Página selecionada:', this.textContent);
        });
    });

    // MIDIA - Publicar imagem com comentário
document.addEventListener("DOMContentLoaded", function () {
    const publicarForm = document.querySelector(".publicar form");
    const galeria = document.querySelector(".galeria");

    if (publicarForm && galeria) {
        publicarForm.addEventListener("submit", function (e) {
            e.preventDefault();

            const fileInput = publicarForm.querySelector('input[type="file"]');
            const comentarioInput = publicarForm.querySelector('textarea');

            const file = fileInput.files[0];
            const comentario = comentarioInput.value;

            if (file && comentario) {
                const reader = new FileReader();

                reader.onload = function (event) {
                    const postagem = document.createElement("div");
                    postagem.classList.add("postagem");
                    postagem.innerHTML = `
                        <img src="${event.target.result}" alt="Foto publicada">
                        <p>${comentario}</p>
                    `;
                    galeria.appendChild(postagem);

                    // Limpa campos
                    fileInput.value = "";
                    comentarioInput.value = "";
                };

                reader.readAsDataURL(file);
            } else {
                alert("Por favor, selecione uma imagem e escreva um comentário.");
            }
        });
    }
});

}