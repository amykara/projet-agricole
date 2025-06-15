
const products = [
    {
        id: 1,
        title: "Tomates Bio",
        price: 2.5,
        unit: "kg",
        location: "Abidjan, Cocody",
        imageUrl: "https://images.unsplash.com/photo-1592924357228-91a4daadcfea?q=80&w=300&auto=format&fit=crop",
        producer: "Ferme de Korhogo"
    },
    {
        id: 2,
        title: "Bananes Plantains",
        price: 3.2,
        unit: "kg",
        location: "Bouaké",
        imageUrl: "https://images.unsplash.com/photo-1603833665858-e61d17a86224?q=80&w=300&auto=format&fit=crop",
        producer: "Plantation Yamoussoukro"
    },
    {
        id: 3,
        title: "Manioc frais",
        price: 1.8,
        unit: "kg",
        location: "San Pedro",
        imageUrl: "https://images.unsplash.com/photo-1598030304671-5aa1d6f21128?q=80&w=300&auto=format&fit=crop",
        producer: "Coopérative de Man"
    },
    {
        id: 4,
        title: "Ignames",
        price: 2.0,
        unit: "kg",
        location: "Daloa",
        imageUrl: "https://images.unsplash.com/photo-1596097635121-14b63cb7a8cf?q=80&w=300&auto=format&fit=crop",
        producer: "Agriculteurs de Bondoukou"
    },
    {
        id: 5,
        title: "Riz local",
        price: 1.5,
        unit: "kg",
        location: "Korhogo",
        imageUrl: "https://images.unsplash.com/photo-1586201375761-83865001e31c?q=80&w=300&auto=format&fit=crop",
        producer: "Coopérative Rizicole"
    }
];

document.addEventListener('DOMContentLoaded', function() {
    // Générer les cartes produits dans le carousel
    const productCardsContainer = document.querySelector('.product-cards');
    
    if (productCardsContainer) {
        products.forEach(product => {
            const productCard = createProductCard(product);
            productCardsContainer.appendChild(productCard);
        });
    }
    
    // Gérer les boutons de navigation du carousel
    setupCarousel();
});

// Fonction pour créer une carte produit
function createProductCard(product) {
    const card = document.createElement('div');
    card.className = 'product-card';
    
    card.innerHTML = `
        <div class="product-image">
            <img src="${product.imageUrl}" alt="${product.title}">
        </div>
        <div class="product-details">
            <div class="product-header">
                <h3 class="product-title">${product.title}</h3>
                <span class="product-price">${product.price} €/${product.unit}</span>
            </div>
            <div class="product-location">
                <i class="fas fa-map-marker-alt"></i>
                <span>${product.location}</span>
            </div>
            <p class="product-producer">Producteur: ${product.producer}</p>
            <div class="product-footer">
                <a href="catalog-item.html?id=${product.id}" class="btn btn-outline">Voir détails</a>
                <a href="https://wa.me/22501020304?text=Bonjour, je suis intéressé par votre produit: ${encodeURIComponent(product.title)}" 
                   class="btn btn-whatsapp">
                    <i class="fab fa-whatsapp"></i> WhatsApp
                </a>
            </div>
        </div>
    `;
    
    return card;
}

// Configuration du carousel de produits
function setupCarousel() {
    const carouselContainer = document.querySelector('.product-carousel');
    if (!carouselContainer) return;
    
    const cardsContainer = carouselContainer.querySelector('.product-cards');
    const prevBtn = carouselContainer.querySelector('.prev');
    const nextBtn = carouselContainer.querySelector('.next');
    
    if (!cardsContainer || !prevBtn || !nextBtn) return;
    
    // Calcul de la largeur à faire défiler
    let cardWidth = 0;
    const cards = cardsContainer.querySelectorAll('.product-card');
    if (cards.length > 0) {
        // Ajouter la marge à la largeur
        cardWidth = cards[0].offsetWidth + parseInt(window.getComputedStyle(cards[0]).marginRight);
    }
    
    // Variables pour le défilement
    let position = 0;
    const visibleCards = getVisibleCardsCount();
    const maxPosition = (cards.length - visibleCards) * cardWidth;
    
    // Fonctions pour les boutons de navigation
    prevBtn.addEventListener('click', () => {
        position = Math.max(position - cardWidth, 0);
        cardsContainer.scrollTo({ left: position, behavior: 'smooth' });
        updateButtonState();
    });
    
    nextBtn.addEventListener('click', () => {
        position = Math.min(position + cardWidth, maxPosition);
        cardsContainer.scrollTo({ left: position, behavior: 'smooth' });
        updateButtonState();
    });
    
    // Mettre à jour l'état des boutons
    function updateButtonState() {
        prevBtn.disabled = position <= 0;
        nextBtn.disabled = position >= maxPosition;
        
        prevBtn.style.opacity = prevBtn.disabled ? '0.5' : '1';
        nextBtn.style.opacity = nextBtn.disabled ? '0.5' : '1';
    }
    
    // Initialiser l'état des boutons
    updateButtonState();
    
    // Recalculer en cas de redimensionnement
    window.addEventListener('resize', () => {
        // Réinitialiser la position
        position = 0;
        cardsContainer.scrollTo({ left: 0 });
        
        // Recalculer
        cardWidth = cards[0].offsetWidth + parseInt(window.getComputedStyle(cards[0]).marginRight);
        const newVisibleCards = getVisibleCardsCount();
        maxPosition = Math.max(0, (cards.length - newVisibleCards) * cardWidth);
        
        updateButtonState();
    });
}

// Détermine le nombre de cartes visibles selon la largeur d'écran
function getVisibleCardsCount() {
    const width = window.innerWidth;
    if (width < 576) return 1;
    if (width < 992) return 2;
    return 3;
}