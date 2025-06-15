/**
 * Product details page JavaScript for AgriConnect
 */

// Function to get URL parameter
const getUrlParameter = (name) => {
    const urlParams = new URLSearchParams(window.location.search);
    return urlParams.get(name);
};

// Function to load product details
const loadProductDetails = () => {
    const productId = getUrlParameter('id');
    const loadingElement = document.getElementById('product-loading');
    const productDetailsElement = document.getElementById('product-details');
    const productNotFoundElement = document.getElementById('product-not-found');
    const relatedProductsSection = document.getElementById('related-products-section');
    
    // Validate required elements
    if (!loadingElement || !productDetailsElement || !productNotFoundElement) {
        console.error('Required DOM elements not found');
        return;
    }
    
    // Validate product ID
    if (!productId) {
        loadingElement.classList.add('hidden');
        productNotFoundElement.classList.remove('hidden');
        return;
    }
    
    // Simulate API call to get product details
    setTimeout(() => {
        // Find product by ID
        const product = mockProducts.find(p => p.id === productId);
        
        // Hide loading
        loadingElement.classList.add('hidden');
        
        if (!product) {
            // Show not found message
            productNotFoundElement.classList.remove('hidden');
            return;
        }
        
        // Get current user
        const currentUser = checkAuth();
        
        // Show product details
        productDetailsElement.classList.remove('hidden');
        
        // Format price
        const formattedPrice = formatCurrency(product.price);
        
        // Find producer
        const producer = mockUsers.find(u => u.id === product.producerId) || {
            name: product.producerName,
            location: product.location,
            rating: 4.5
        };
        
        // Build HTML
        productDetailsElement.innerHTML = `
            <div class="grid grid-cols-1 md:grid-cols-2 gap-8">
                <div>
                    <div class="relative mb-4">
                        <img 
                            src="${product.imageUrl}" 
                            alt="${product.title}" 
                            class="rounded-lg shadow-md w-full h-auto aspect-square object-cover"
                        />
                        <div class="absolute top-4 right-4">
                            ${getProductStatusBadgeHTML(product.status)}
                        </div>
                    </div>
                    
                    <div class="grid grid-cols-4 gap-2">
                        <img 
                            src="${product.imageUrl}" 
                            alt="Thumbnail" 
                            class="rounded-md cursor-pointer border-2 border-agri-primary"
                        />
                        <!-- Additional thumbnails would go here in a real app -->
                    </div>
                </div>
                
                <div>
                    <h1 class="text-3xl font-bold mb-2">${product.title}</h1>
                    
                    <div class="flex items-center mb-4">
                        <span class="bg-agri-primary/10 text-agri-primary px-3 py-1 rounded-full text-sm mr-3">
                            ${product.category}
                        </span>
                        <span class="text-gray-600 text-sm">
                            <i class="fas fa-map-marker-alt mr-1"></i> ${product.location}
                        </span>
                    </div>
                    
                    <div class="mb-4">
                        <p class="text-gray-600">
                            ${product.description}
                        </p>
                    </div>
                    
                    <div class="flex justify-between items-center mb-6 pb-4 border-b border-gray-200">
                        <div>
                            <p class="text-sm text-gray-500">Prix</p>
                            <p class="text-3xl font-bold text-agri-primary">
                                ${formattedPrice}
                                <span class="text-sm text-gray-500">/${product.unit}</span>
                            </p>
                        </div>
                        
                        <div class="text-right">
                            <p class="text-sm text-gray-500">Disponibilité</p>
                            <p class="text-lg font-medium">
                                ${product.quantity} ${product.unit}
                            </p>
                        </div>
                    </div>
                    
                    <div class="bg-white rounded-lg border border-gray-200 p-4 mb-6">
                        <div class="flex items-center">
                            <div class="w-12 h-12 bg-agri-secondary rounded-full flex items-center justify-center text-white font-bold text-xl mr-4">
                                ${getUserInitials(producer.name)}
                            </div>
                            <div>
                                <h3 class="font-semibold">${producer.name}</h3>
                                <div class="flex items-center text-sm">
                                    <span class="text-agri-yellow flex items-center mr-2">
                                        <i class="fas fa-star mr-1"></i>${producer.rating}
                                    </span>
                                    <span class="text-gray-500">${producer.location}</span>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <div class="${product.status === 'active' ? '' : 'hidden'}">
                        <div class="grid grid-cols-1 sm:grid-cols-2 gap-4 ${currentUser ? '' : 'hidden'}">
                            <button 
                                id="contact-producer-btn"
                                class="bg-agri-primary hover:bg-agri-primary/90 text-white py-3 px-4 rounded-md transition-colors duration-200 font-medium"
                            >
                                <i class="fas fa-comment mr-2"></i> Contacter le producteur
                            </button>
                            
                            <button 
                                id="whatsapp-producer-btn"
                                class="border border-green-600 text-green-600 hover:bg-green-50 py-3 px-4 rounded-md transition-colors duration-200 font-medium"
                            >
                                <i class="fab fa-whatsapp mr-2"></i> WhatsApp
                            </button>
                        </div>
                        
                        <button 
                            id="login-required-btn"
                            class="bg-agri-primary hover:bg-agri-primary/90 text-white py-3 px-4 rounded-md transition-colors duration-200 font-medium w-full ${currentUser ? 'hidden' : ''}"
                        >
                            Se connecter pour contacter le producteur
                        </button>
                    </div>
                    
                    <div class="${product.status !== 'active' ? '' : 'hidden'} mt-4">
                        <div class="bg-gray-100 border border-gray-200 rounded-md p-4 text-center text-gray-600">
                            <i class="fas fa-info-circle mr-2"></i>
                            Ce produit n'est plus disponible actuellement.
                        </div>
                    </div>
                </div>
            </div>
        `;
        
        // Add event listeners
        const contactProducerBtn = document.getElementById('contact-producer-btn');
        const whatsappProducerBtn = document.getElementById('whatsapp-producer-btn');
        const loginRequiredBtn = document.getElementById('login-required-btn');
        
        if (contactProducerBtn) {
            contactProducerBtn.addEventListener('click', () => {
                showContactModal(product);
            });
        }
        
        if (whatsappProducerBtn) {
            whatsappProducerBtn.addEventListener('click', () => {
                const message = `Bonjour, je suis intéressé par votre produit "${product.title}" à ${formattedPrice} sur AgriConnect.`;
                openWhatsApp('', message);
            });
        }
        
        if (loginRequiredBtn) {
            loginRequiredBtn.addEventListener('click', showLoginRequiredModal);
        }
        
        // Load related products
        loadRelatedProducts(product);
    }, 800);
};

// Function to load related products
const loadRelatedProducts = (currentProduct) => {
    const relatedProductsSection = document.getElementById('related-products-section');
    const relatedProductsContainer = document.getElementById('related-products');
    
    if (!relatedProductsSection || !relatedProductsContainer) {
        return;
    }
    
    // Get products in the same category, excluding the current product
    const relatedProducts = mockProducts.filter(p => 
        p.category === currentProduct.category && 
        p.id !== currentProduct.id &&
        p.status === 'active'
    );
    
    // Show section only if we have related products
    if (relatedProducts.length === 0) {
        return;
    }
    
    relatedProductsSection.classList.remove('hidden');
    relatedProductsContainer.innerHTML = '';
    
    // Get current user
    const currentUser = checkAuth();
    
    // Limit to 4 products
    const limitedProducts = relatedProducts.slice(0, 4);
    
    // Create product cards
    limitedProducts.forEach(product => {
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
            </div>
            
            <div class="p-4">
                <h3 class="font-semibold text-lg line-clamp-1">${product.title}</h3>
                <p class="text-sm text-gray-500">${product.location}</p>
                <p class="text-sm text-gray-600 mb-2 line-clamp-2">${product.description}</p>
                
                <div class="pt-3 border-t border-gray-100">
                    <div class="flex justify-between items-center">
                        <p class="font-bold text-lg text-agri-primary">
                            ${formattedPrice}
                            <span class="text-xs text-gray-500 ml-1">/${product.unit}</span>
                        </p>
                    </div>
                </div>
            </div>
        `;
        
        relatedProductsContainer.appendChild(card);
        
        // Make the card clickable
        card.addEventListener('click', () => {
            window.location.href = `product-details.html?id=${product.id}`;
        });
    });
};

// Function to show login required modal
const showLoginRequiredModal = () => {
    const modal = document.getElementById('login-required-modal');
    const closeBtn = document.getElementById('close-login-modal');
    
    if (!modal) {
        return;
    }
    
    // Show modal
    modal.classList.remove('hidden');
    
    // Close button event
    if (closeBtn) {
        closeBtn.addEventListener('click', () => {
            modal.classList.add('hidden');
        });
    }
    
    // Close on outside click
    modal.addEventListener('click', (e) => {
        if (e.target === modal) {
            modal.classList.add('hidden');
        }
    });
};

// Function to show contact modal
const showContactModal = (product) => {
    const modal = document.getElementById('contact-modal');
    const closeBtn = document.getElementById('close-contact-modal');
    const cancelBtn = document.getElementById('cancel-contact');
    const form = document.getElementById('contact-form');
    const messageInput = document.getElementById('contact-message');
    
    if (!modal || !form) {
        return;
    }
    
    // Set default message
    if (messageInput) {
        messageInput.value = `Bonjour, je suis intéressé par votre produit "${product.title}" à ${formatCurrency(product.price)}. Pourrions-nous en discuter?`;
    }
    
    // Show modal
    modal.classList.remove('hidden');
    
    // Close button events
    if (closeBtn) {
        closeBtn.addEventListener('click', () => {
            modal.classList.add('hidden');
        });
    }
    
    if (cancelBtn) {
        cancelBtn.addEventListener('click', () => {
            modal.classList.add('hidden');
        });
    }
    
    // Close on outside click
    modal.addEventListener('click', (e) => {
        if (e.target === modal) {
            modal.classList.add('hidden');
        }
    });
    
    // Form submission
    form.addEventListener('submit', (e) => {
        e.preventDefault();
        
        if (!messageInput || !messageInput.value.trim()) {
            createToast('Veuillez entrer un message', 'error');
            return;
        }
        
        // Simulate sending message
        setTimeout(() => {
            createToast('Message envoyé avec succès! Le producteur vous contactera prochainement.', 'success');
            modal.classList.add('hidden');
        }, 800);
    });
};

// Initialize page when DOM is loaded
document.addEventListener('DOMContentLoaded', () => {
    loadProductDetails();
});