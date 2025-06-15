  
        document.addEventListener('DOMContentLoaded', function() {
            // Gestion des filtres
            const toggleFiltersBtn = document.getElementById('toggle-filters');
            const filtersContainer = document.getElementById('filters-container');
            
            toggleFiltersBtn.addEventListener('click', function() {
                filtersContainer.classList.toggle('show');
                
                // Changer l'icône
                const icon = this.querySelector('i');
                if (filtersContainer.classList.contains('show')) {
                    icon.classList.remove('fa-filter');
                    icon.classList.add('fa-times');
                } else {
                    icon.classList.remove('fa-times');
                    icon.classList.add('fa-filter');
                }
            });
            
            // Gestion des selects
            const selectTriggers = document.querySelectorAll('.select-trigger');
            
            selectTriggers.forEach(trigger => {
                trigger.addEventListener('click', function() {
                    const contentId = this.id.replace('-trigger', '-content');
                    const content = document.getElementById(contentId);
                    
                    // Fermer tous les autres selects
                    document.querySelectorAll('.select-content').forEach(item => {
                        if (item.id !== contentId) {
                            item.classList.remove('show');
                        }
                    });
                    
                    // Ouvrir/fermer ce select
                    content.classList.toggle('show');
                });
            });
            
            // Sélection d'un item dans un select
            document.querySelectorAll('.select-item').forEach(item => {
                item.addEventListener('click', function() {
                    const content = this.closest('.select-content');
                    const triggerId = content.id.replace('-content', '-trigger');
                    const trigger = document.getElementById(triggerId);
                    
                    // Mettre à jour le texte du trigger
                    trigger.querySelector('span').textContent = this.textContent;
                    
                    // Fermer le select
                    content.classList.remove('show');
                });
            });
            
            // Fermer les selects quand on clique ailleurs
            document.addEventListener('click', function(e) {
                if (!e.target.closest('.select')) {
                    document.querySelectorAll('.select-content').forEach(content => {
                        content.classList.remove('show');
                    });
                }
            });
            
            // Réinitialiser les filtres
            document.getElementById('reset-filters').addEventListener('click', function() {
                document.querySelectorAll('.select-trigger span').forEach(span => {
                    if (span.textContent !== 'Toutes les catégories' && 
                        span.textContent !== 'Toute la Côte d\'Ivoire' && 
                        span.textContent !== 'Tous les conditionnements' && 
                        span.textContent !== 'Date (plus récent)') {
                        span.textContent = 'Toutes les catégories';
                    }
                });
            });
            
            // Appliquer les filtres
            document.getElementById('apply-filters').addEventListener('click', function() {
                filtersContainer.classList.remove('show');
                toggleFiltersBtn.querySelector('i').classList.remove('fa-times');
                toggleFiltersBtn.querySelector('i').classList.add('fa-filter');
                // Ici vous ajouteriez la logique pour filtrer les produits
            });
            
            // Animation de la barre de recherche
            const searchInput = document.getElementById('search-input');
            
            searchInput.addEventListener('focus', function() {
                this.parentElement.classList.add('search-pulse');
            });
            
            searchInput.addEventListener('blur', function() {
                this.parentElement.classList.remove('search-pulse');
            });
            
            // Navigation des mini producteurs
            const miniProducersScroller = document.getElementById('mini-producers-scroller');
            const miniProducersPrev = document.querySelector('.mini-producers-prev');
            const miniProducersNext = document.querySelector('.mini-producers-next');
            const autoScroll = document.querySelector('.auto-scroll');
            
            // Dupliquer les producteurs pour un défilement infini
            const producers = autoScroll.innerHTML;
            autoScroll.innerHTML += producers;
            
            // Défilement automatique très lent
            let scrollSpeed = 1; // Vitesse de défilement (pixels par frame)
            let scrollPosition = 0;
            
            function autoScrollProducers() {
                scrollPosition += scrollSpeed;
                
                // Si on arrive à la fin, revenir au début
                if (scrollPosition >= autoScroll.scrollWidth / 2) {
                    scrollPosition = 0;
                }
                
                miniProducersScroller.scrollLeft = scrollPosition;
                requestAnimationFrame(autoScrollProducers);
            }
            
            // Démarrer le défilement automatique
            autoScrollProducers();
            
            // Navigation manuelle
            miniProducersPrev.addEventListener('click', function() {
                scrollPosition -= 200;
                if (scrollPosition < 0) {
                    scrollPosition = autoScroll.scrollWidth / 2 - miniProducersScroller.offsetWidth;
                }
                miniProducersScroller.scrollTo({
                    left: scrollPosition,
                    behavior: 'smooth'
                });
            });
            
            miniProducersNext.addEventListener('click', function() {
                scrollPosition += 200;
                if (scrollPosition >= autoScroll.scrollWidth / 2) {
                    scrollPosition = 0;
                }
                miniProducersScroller.scrollTo({
                    left: scrollPosition,
                    behavior: 'smooth'
                });
            });
            
            // Animation des cartes de produits
            const observerOptions = {
                threshold: 0.1,
                rootMargin: '0px 0px -50px 0px'
            };
            
            const observer = new IntersectionObserver((entries, observer) => {
                entries.forEach(entry => {
                    if (entry.isIntersecting) {
                        entry.target.style.opacity = '1';
                        entry.target.style.transform = 'translateY(0)';
                        observer.unobserve(entry.target);
                    }
                });
            }, observerOptions);
            
            document.querySelectorAll('.produit-card').forEach(card => {
                observer.observe(card);
            });
            
            // Animation de flottement pour le bouton "Voir plus"
            const seeMoreBtn = document.querySelector('.hover\\:animate-float');
            
            seeMoreBtn.addEventListener('mouseenter', function() {
                this.style.animation = 'float 2s ease-in-out infinite';
            });
            
            seeMoreBtn.addEventListener('mouseleave', function() {
                this.style.animation = 'none';
            });
        });
        // Ajoutez ce code dans votre script existant
window.addEventListener('scroll', function() {
    const header = document.querySelector('.produits-header');
    const miniProducers = document.querySelector('.mini-producers');
    const filters = document.querySelector('.filters-container');
    const searchSection = document.querySelector('.search-section');
    
    if (window.scrollY > header.offsetHeight) {
        // Quand on a défilé plus que la hauteur de la bannière
        miniProducers.style.top = '0';
        if (filters.classList.contains('show')) {
            filters.style.top = miniProducers.offsetHeight + 'px';
            searchSection.style.top = (miniProducers.offsetHeight + filters.offsetHeight) + 'px';
        } else {
            searchSection.style.top = miniProducers.offsetHeight + 'px';
        }
    } else {
        // Quand on est en haut de la page
        miniProducers.style.top = (header.offsetHeight - window.scrollY) + 'px';
        if (filters.classList.contains('show')) {
            filters.style.top = (header.offsetHeight - window.scrollY + miniProducers.offsetHeight) + 'px';
            searchSection.style.top = (header.offsetHeight - window.scrollY + miniProducers.offsetHeight + filters.offsetHeight) + 'px';
        } else {
            searchSection.style.top = (header.offsetHeight - window.scrollY + miniProducers.offsetHeight) + 'px';
        }
    }
});
