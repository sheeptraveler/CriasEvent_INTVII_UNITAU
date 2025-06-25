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

// Inscricao 
document.querySelectorAll('.buy-button').forEach(button => {
    button.addEventListener('click', function(e) {
        e.preventDefault();

        const eventoId = this.getAttribute('data-evento-id');

        fetch('/inscrever', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
                'X-CSRFToken': getCookie('csrf_token') // se estiver usando CSRF no Flask-WTF
            },
            body: JSON.stringify({ evento_id: eventoId })
        })
        .then(response => response.json())
        .then(data => {
            if (data.sucesso) {
                this.textContent = 'Inscrito!';
                this.disabled = true;
            } else {
                alert('Erro: ' + data.mensagem);
            }
        })
        .catch(err => alert('Erro na requisição: ' + err));
    });
});

function abrirPainel() {
    document.getElementById('painelPublicacao').classList.toggle('ativo');
}


// Função para pegar cookie CSRF (se usar)
// Pode ser omitido se não usar CSRF no backend.
function getCookie(name) {
    let match = document.cookie.match(new RegExp('(^| )' + name + '=([^;]+)'));
    if (match) return match[2];
}

document.getElementById('abrirPainelBtn').addEventListener('click', () => {
    document.getElementById('painelPublicacao').classList.add('ativo');
});

document.getElementById('fecharPainelBtn').addEventListener('click', () => {
    document.getElementById('painelPublicacao').classList.remove('ativo');
});

document.getElementById('formPublicacao').addEventListener('submit', async function(e) {
    e.preventDefault();

    const form = new FormData(this);
    
    const response = await fetch('/publicar', {
        method: 'POST',
        body: form
    });

    const resultado = await response.json();

    alert(resultado.mensagem || 'Publicado!');
    document.getElementById('painelPublicacao').classList.remove('ativo');
    window.location.reload();  // Recarrega a página pra mostrar a nova publicação
});

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
