
/**
 * Main JavaScript for AgriConnect
 */

// Mock data for products
const mockProducts = [
    {
        id: '1',
        title: 'Tomates Bio',
        description: 'Tomates fraîches cultivées sans pesticides. Idéales pour salades et sauces.',
        price: 1500,
        quantity: 50,
        unit: 'kg',
        category: 'Légumes',
        location: 'Thiès',
        imageUrl: 'img/tomatoes.jpg',
        producerId: '2',
        producerName: 'Marie Producteur',
        status: 'active',
        createdAt: new Date('2023-06-01')
    },
    {
        id: '2',
        title: 'Mangues Kent',
        description: 'Mangues juteuses et sucrées de variété Kent. Cultivées naturellement.',
        price: 2000,
        quantity: 30,
        unit: 'kg',
        category: 'Fruits',
        location: 'Dakar',
        imageUrl: 'img/mangoes.jpg',
        producerId: '2',
        producerName: 'Marie Producteur',
        status: 'active',
        createdAt: new Date('2023-06-03')
    },
    {
        id: '3',
        title: 'Pommes de terre',
        description: 'Pommes de terre fraîches cultivées localement.',
        price: 800,
        quantity: 100,
        unit: 'kg',
        category: 'Légumes',
        location: 'Saint-Louis',
        imageUrl: 'img/potatoes.jpg',
        producerId: '5',
        producerName: 'Ousmane Diop',
        status: 'active',
        createdAt: new Date('2023-06-05')
    },
    {
        id: '4',
        title: 'Lait frais',
        description: 'Lait frais de vache, non pasteurisé. Production journalière.',
        price: 1000,
        quantity: 20,
        unit: 'L',
        category: 'Produits laitiers',
        location: 'Louga',
        imageUrl: 'img/milk.jpg',
        producerId: '6',
        producerName: 'Ibrahima Producteur',
        status: 'active',
        createdAt: new Date('2023-06-06')
    },
    {
        id: '5',
        title: 'Carottes Bio',
        description: 'Carottes fraîches et croquantes cultivées en agriculture biologique.',
        price: 1200,
        quantity: 40,
        unit: 'kg',
        category: 'Légumes',
        location: 'Thiès',
        imageUrl: 'img/carrots.jpg',
        producerId: '2',
        producerName: 'Marie Producteur',
        status: 'active',
        createdAt: new Date('2023-06-07')
    },
    {
        id: '6',
        title: 'Oignons rouges',
        description: 'Oignons rouges de qualité supérieure, parfaits pour les salades et les sauces.',
        price: 950,
        quantity: 75,
        unit: 'kg',
        category: 'Légumes',
        location: 'Saint-Louis',
        imageUrl: 'img/onions.jpg',
        producerId: '5',
        producerName: 'Ousmane Diop',
        status: 'active',
        createdAt: new Date('2023-06-08')
    }
];

// Function to load featured products on homepage
const loadFeaturedProducts = () => {
    const featuredProductsContainer = document.getElementById('featured-products');
    
    if (!featuredProductsContainer) {
        return;
    }
    
    // Clear container
    featuredProductsContainer.innerHTML = '';
    
    // Get active products and sort by date (newest first)
    const activeProducts = mockProducts
        .filter(p => p.status === 'active')
        .sort((a, b) => b.createdAt - a.createdAt);
    
    // Get the first 4 products
    const featuredProducts = activeProducts.slice(0, 4);
    
    // Get current user
    const currentUser = checkAuth();
    
    // Create product cards
    featuredProducts.forEach(product => {
        const card = document.createElement('div');
        card.className = 'bg-white rounded-lg shadow-md hover:shadow-lg transition-shadow duration-300 overflow-hidden border border-agri-gray/20 animate-fade-in';
        
        // Format price
        const formattedPrice = formatCurrency(product.price);
        
        card.innerHTML = `
            <div class="relative overflow-hidden rounded-t-lg aspect-square">
                <img 
                    src="${product.imageUrl}" 
                    alt="${product.title}" 
                    class="w-full h-full object-cover object-center transition-transform group-hover:scale-105 duration-300"
                />
                <div class="absolute top-2 right-2">
                    ${getProductStatusBadgeHTML(product.status)}
                </div>
            </div>
            
            <div class="p-4 flex flex-col h-full">
                <div class="mb-2">
                    <h3 class="font-semibold text-lg line-clamp-1">${product.title}</h3>
                    <p class="text-sm text-gray-500">${product.location}</p>
                </div>
                
                <p class="text-sm text-gray-600 mb-2 line-clamp-2">${product.description}</p>
                
                <div class="mt-auto pt-4 border-t border-gray-100">
                    <div class="flex justify-between items-center">
                        <p class="font-bold text-lg text-agri-primary">
                            ${formattedPrice}
                            <span class="text-xs text-gray-500 ml-1">/${product.unit}</span>
                        </p>
                        <p class="text-sm text-gray-600">
                            ${product.quantity} ${product.unit} disponibles
                        </p>
                    </div>
                    
                    <div class="mt-3 flex gap-2 ${currentUser ? '' : 'hidden'}">
                        <a 
                            href="product-details.html?id=${product.id}" 
                            class="bg-agri-primary hover:bg-agri-primary/90 text-white py-2 px-4 rounded-md transition-colors duration-200 font-medium flex-1 text-center"
                        >
                            Contacter
                        </a>
                        <button 
                            class="border-agri-primary text-agri-primary hover:bg-agri-primary/10 py-2 px-4 rounded-md transition-colors duration-200 font-medium flex-1 whatsapp-btn"
                            data-product="${product.title}"
                            data-price="${formattedPrice}"
                        >
                            WhatsApp
                        </button>
                    </div>
                    
                    <div class="mt-3 ${currentUser ? 'hidden' : ''}">
                        <a 
                            href="login.html" 
                            class="bg-agri-primary hover:bg-agri-primary/90 text-white py-2 px-4 rounded-md transition-colors duration-200 font-medium w-full block text-center"
                        >
                            Connexion pour contacter
                        </a>
                    </div>
                </div>
            </div>
        `;
        
        featuredProductsContainer.appendChild(card);
        
        // Add event listeners for WhatsApp buttons
        const whatsappButtons = card.querySelectorAll('.whatsapp-btn');
        whatsappButtons.forEach(button => {
            button.addEventListener('click', (e) => {
                e.preventDefault();
                e.stopPropagation();
                
                const productTitle = button.getAttribute('data-product');
                const productPrice = button.getAttribute('data-price');
                
                const message = `Bonjour, je suis intéressé par votre produit "${productTitle}" à ${productPrice} sur AgriConnect.`;
                openWhatsApp('', message);
            });
        });
        
        // Make the entire card clickable
        card.addEventListener('click', () => {
            window.location.href = `product-details.html?id=${product.id}`;
        });
    });
};



// Initialize page when DOM is loaded
document.addEventListener('DOMContentLoaded', () => {
    // Initialize tabs if present
    initializeTabs();
    
    // Initialize dashboard navigation if present
    initializeDashboardNav();
    
    // Initialize accordions if present
    initializeAccordions();
    
    // Initialize star rating if present
    initializeStarRating();
    
    // Load page-specific content
    loadPageContent();
});
// Attendre que le DOM soit entièrement chargé
document.addEventListener('DOMContentLoaded', function() {
    // === Menu mobile ===
    const mobileMenuToggle = document.querySelector('.mobile-menu-toggle');
    const navMobile = document.querySelector('.nav-mobile');
    
    if (mobileMenuToggle && navMobile) {
        mobileMenuToggle.addEventListener('click', function() {
            navMobile.style.display = navMobile.style.display === 'block' ? 'none' : 'block';
            
            // Changer l'icône du menu
            const icon = this.querySelector('i');
            if (icon.classList.contains('fa-bars')) {
                icon.classList.remove('fa-bars');
                icon.classList.add('fa-times');
            } else {
                icon.classList.remove('fa-times');
                icon.classList.add('fa-bars');
            }
        });
    }
    
    // === Toast notifications ===
    const toast = document.getElementById('toast');
    
    // Fonction pour afficher une notification
    window.showToast = function(message, type = 'success') {
        if (!toast) return;
        
        const toastIcon = toast.querySelector('.toast-icon');
        const toastMessage = toast.querySelector('.toast-message');
        
        // Définir le type d'icône en fonction du type de notification
        if (toastIcon) {
            toastIcon.className = 'fas toast-icon';
            
            switch(type) {
                case 'success':
                    toastIcon.classList.add('fa-check-circle');
                    toastIcon.style.color = 'var(--color-success)';
                    break;
                case 'warning':
                    toastIcon.classList.add('fa-exclamation-circle');
                    toastIcon.style.color = 'var(--color-warning)';
                    break;
                case 'error':
                    toastIcon.classList.add('fa-times-circle');
                    toastIcon.style.color = 'var(--color-danger)';
                    break;
                default:
                    toastIcon.classList.add('fa-info-circle');
                    toastIcon.style.color = 'var(--color-primary)';
            }
        }
        
        // Définir le message
        if (toastMessage) {
            toastMessage.textContent = message;
        }
        
        // Afficher la notification
        toast.classList.add('show');
        
        // Cacher après 5 secondes
        setTimeout(function() {
            toast.classList.remove('show');
        }, 5000);
    };
    
    // Fermer le toast en cliquant sur le bouton de fermeture
    const toastClose = document.querySelector('.toast-close');
    if (toastClose && toast) {
        toastClose.addEventListener('click', function() {
            toast.classList.remove('show');
        });
    }
    
    // === Année courante dans le footer ===
    const yearEl = document.getElementById('current-year');
    if (yearEl) {
        yearEl.textContent = new Date().getFullYear();
    }
    
    // === Vérifier si l'utilisateur est connecté ===
    // Cette fonction simule la vérification de connexion
    // Dans une application réelle, vous utiliseriez des cookies, localStorage ou une API
    window.isUserLoggedIn = function() {
        // Pour la démonstration, retournons false
        return false;
    };
    
    // === Fonction pour rediriger vers login si l'utilisateur n'est pas connecté ===
    window.requireLogin = function(event, redirectUrl) {
        if (!isUserLoggedIn()) {
            event.preventDefault();
            showToast('Vous devez être connecté pour accéder à cette fonctionnalité', 'warning');
            
            // Optionnel: rediriger vers la page de connexion après un délai
            setTimeout(function() {
                window.location.href = 'login.html';
            }, 1500);
            
            return false;
        }
        return true;
    };
    
    // === Gestion des boutons WhatsApp ===
    document.addEventListener('click', function(e) {
        if (e.target && e.target.classList.contains('btn-whatsapp')) {
            if (!isUserLoggedIn()) {
                e.preventDefault();
                showToast('Vous devez être connecté pour contacter un producteur', 'warning');
            }
        }
    });
});
