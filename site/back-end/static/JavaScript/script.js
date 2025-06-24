// =====================
// script.js - Código Global para CriasEvent
// =====================


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


// ===================
// SLIDER DO BANNER (index.html)
// ===================
if (document.querySelector('.banner')) {
    let currentSlide = 0;
    const slides = document.querySelectorAll('.slide');
    const totalSlides = slides.length;

    function showSlide(n) {
        slides.forEach(slide => slide.classList.remove('active'));
        currentSlide = (n + totalSlides) % totalSlides;
        slides[currentSlide].classList.add('active');
    }

    document.querySelector('.banner-prev')?.addEventListener('click', () => {
        showSlide(currentSlide - 1);
    });

    document.querySelector('.banner-next')?.addEventListener('click', () => {
        showSlide(currentSlide + 1);
    });

    // Auto-avanço (opcional)
    // setInterval(() => {
    //     showSlide(currentSlide + 1);
    // }, 5000);
}


// ===================
// FUNÇÕES GERAIS AO CARREGAR A PÁGINA
// ===================
document.addEventListener('DOMContentLoaded', function () {

    // ============ FILTROS DE EVENTOS (eventos.html) ============
    const filterButtons = document.querySelectorAll('.filter-btn');
    const eventCards = document.querySelectorAll('.card');

    if (filterButtons.length) {
        filterButtons.forEach(button => {
            button.addEventListener('click', function () {
                filterButtons.forEach(btn => btn.classList.remove('active'));
                this.classList.add('active');

                const filterValue = this.getAttribute('data-category');

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
    }


    // ============ PAGINAÇÃO (eventos.html) ============
    const pageButtons = document.querySelectorAll('.page-btn');
    if (pageButtons.length) {
        pageButtons.forEach(btn => {
            btn.addEventListener('click', function () {
                if (!this.classList.contains('next')) {
                    pageButtons.forEach(b => b.classList.remove('active'));
                    this.classList.add('active');
                }
                console.log('Página selecionada:', this.textContent);
                // Aqui você pode futuramente implementar o carregamento real das páginas
            });
        });
    }


    // ============ PUBLICAÇÃO DE IMAGENS (midia.html) ============
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

}); // Fim do DOMContentLoaded



// ===================
// MENU DO PERFIL (Header)
// ===================
function toggleMenu() {
    const menu = document.getElementById("profileMenu");
    if (menu) {
        menu.style.display = (menu.style.display === "block") ? "none" : "block";
    }
}

// Fecha o menu clicando fora
window.onclick = function (event) {
    if (!event.target.matches('.profile-button')) {
        const dropdowns = document.getElementsByClassName("profile-menu");
        for (let i = 0; i < dropdowns.length; i++) {
            const openDropdown = dropdowns[i];
            if (openDropdown.style.display === "block") {
                openDropdown.style.display = "none";
            }
        }
    }
};
