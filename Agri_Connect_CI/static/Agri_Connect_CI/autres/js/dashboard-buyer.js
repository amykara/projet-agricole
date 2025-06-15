
/**
 * Buyer Dashboard JavaScript for AgriConnect
 */

// Mock connections data
const mockConnections = [
    {
        id: '1',
        sellerId: '2',
        sellerName: 'Marie Producteur',
        productId: '1',
        productName: 'Tomates Bio',
        status: 'completed',
        createdAt: new Date('2023-06-12'),
        buyerRating: 5,
        sellerRating: 4,
        buyerComment: "Parfait! Les tomates étaient très fraîches.",
        sellerComment: "Client très agréable et ponctuel.",
        imageUrl: 'img/tomatoes.jpg'
    },
    {
        id: '2',
        sellerId: '5',
        sellerName: 'Ousmane Diop',
        productId: '3',
        productName: 'Pommes de terre',
        status: 'accepted',
        createdAt: new Date('2023-06-15'),
        imageUrl: 'img/potatoes.jpg'
    },
    {
        id: '3',
        sellerId: '2',
        sellerName: 'Marie Producteur',
        productId: '2',
        productName: 'Mangues Kent',
        status: 'pending',
        createdAt: new Date('2023-06-16'),
        imageUrl: 'img/mangoes.jpg'
    }
];

// Mock favorites data
const mockFavorites = [
    {
        id: '1',
        productId: '1',
        productName: 'Tomates Bio',
        productImage: 'img/tomatoes.jpg',
        producerId: '2',
        producerName: 'Marie Producteur',
        price: 1500,
        unit: 'kg',
        location: 'Thiès'
    },
    {
        id: '2',
        productId: '5',
        productName: 'Carottes Bio',
        productImage: 'img/carrots.jpg',
        producerId: '2',
        producerName: 'Marie Producteur',
        price: 1200,
        unit: 'kg',
        location: 'Thiès'
    }
];

// Function to load user data
const loadUserData = () => {
    const currentUser = checkAuth();
    
    if (!currentUser) {
        // Redirect to login if not authenticated
        window.location.href = 'login.html';
        return;
    }
    
    // Update user name
    const userNameElements = document.querySelectorAll('#user-name');
    const welcomeNameElement = document.getElementById('welcome-name');
    const userAvatarInitialElements = document.querySelectorAll('#user-avatar-initial, #profile-avatar-initial');
    
    userNameElements.forEach(el => {
        if (el) el.textContent = currentUser.name;
    });
    
    if (welcomeNameElement) {
        welcomeNameElement.textContent = currentUser.name.split(' ')[0]; // First name only
    }
    
    userAvatarInitialElements.forEach(el => {
        if (el) el.textContent = getUserInitials(currentUser.name);
    });
    
    // Load profile data if on profile section
    const profileForm = document.getElementById('profile-form');
    if (profileForm) {
        const nameInput = document.getElementById('profile-name');
        const emailInput = document.getElementById('profile-email');
        const phoneInput = document.getElementById('profile-phone');
        const locationInput = document.getElementById('profile-location');
        const bioInput = document.getElementById('profile-bio');
        
        if (nameInput) nameInput.value = currentUser.name;
        if (emailInput) emailInput.value = currentUser.email;
        if (phoneInput) phoneInput.value = currentUser.phone || '';
        if (locationInput) locationInput.value = currentUser.location || '';
        if (bioInput) bioInput.value = currentUser.bio || '';
        
        // Handle profile form submission
        profileForm.addEventListener('submit', (e) => {
            e.preventDefault();
            
            // Show success toast
            createToast('Votre profil a été mis à jour avec succès', 'success');
        });
    }
};

// Function to load recent products
const loadRecentProducts = () => {
    const recentProductsContainer = document.getElementById('recent-products');
    
    if (!recentProductsContainer) {
        return;
    }
    
    // Clear container
    recentProductsContainer.innerHTML = '';
    
    // Get active products and sort by date (newest first)
    const activeProducts = mockProducts
        .filter(p => p.status === 'active')
        .sort((a, b) => b.createdAt - a.createdAt);
    
    // Get the first 4 products
    const recentProducts = activeProducts.slice(0, 4);
    
    // Create product cards
    recentProducts.forEach(product => {
        const card = document.createElement('div');
        card.className = 'bg-white rounded-lg shadow-sm border border-gray-100 hover:shadow-md transition-shadow';
        
        // Format price
        const formattedPrice = formatCurrency(product.price);
        
        card.innerHTML = `
            <div class="flex">
                <div class="w-24 h-24 overflow-hidden">
                    <img 
                        src="${product.imageUrl}" 
                        alt="${product.title}" 
                        class="w-full h-full object-cover rounded-l-lg"
                    />
                </div>
                <div class="p-3 flex-1">
                    <h3 class="font-medium line-clamp-1">${product.title}</h3>
                    <p class="text-sm text-gray-500">${product.location}</p>
                    <p class="font-bold text-agri-primary mt-1">
                        ${formattedPrice}
                        <span class="text-xs text-gray-500 ml-1">/${product.unit}</span>
                    </p>
                </div>
            </div>
        `;
        
        recentProductsContainer.appendChild(card);
        
        // Make the card clickable
        card.addEventListener('click', () => {
            window.location.href = `product-details.html?id=${product.id}`;
        });
    });
};

// Function to load connections
const loadConnections = () => {
    const connectionsContainer = document.getElementById('connections-list');
    
    if (!connectionsContainer) {
        return;
    }
    
    // Clear container
    connectionsContainer.innerHTML = '';
    
    // Get active filter (default: all)
    const activeFilter = document.querySelector('.connection-filter.active')?.getAttribute('data-filter') || 'all';
    
    // Filter connections
    let filteredConnections = [...mockConnections];
    
    if (activeFilter !== 'all') {
        filteredConnections = filteredConnections.filter(c => c.status === activeFilter);
    }
    
    // Check if we have connections
    if (filteredConnections.length === 0) {
        connectionsContainer.innerHTML = `
            <div class="text-center py-8 text-gray-500">
                <i class="fas fa-exchange-alt text-4xl mb-3 opacity-30"></i>
                <p>Aucune mise en relation trouvée</p>
                <p class="text-sm mt-1">Commencez par contacter des producteurs</p>
            </div>
        `;
        return;
    }
    
    // Sort by date (newest first)
    filteredConnections.sort((a, b) => b.createdAt - a.createdAt);
    
    // Create connection cards
    filteredConnections.forEach(connection => {
        const card = document.createElement('div');
        card.className = 'bg-white rounded-lg shadow-sm border border-gray-100 p-4 hover:shadow-md transition-shadow';
        
        card.innerHTML = `
            <div class="sm:flex justify-between">
                <div class="flex mb-3 sm:mb-0">
                    <div class="w-16 h-16 overflow-hidden rounded-md mr-3">
                        <img 
                            src="${connection.imageUrl}" 
                            alt="${connection.productName}" 
                            class="w-full h-full object-cover"
                        />
                    </div>
                    <div>
                        <h3 class="font-semibold">${connection.productName}</h3>
                        <p class="text-sm text-gray-500">${connection.sellerName}</p>
                        <div class="flex items-center mt-1">
                            ${connection.sellerRating ? getRatingStarsHTML(connection.sellerRating) : ''}
                        </div>
                    </div>
                </div>
                
                <div class="flex flex-col items-end">
                    ${getConnectionStatusBadgeHTML(connection.status)}
                    <p class="text-xs text-gray-500 mt-1">${formatDate(connection.createdAt)}</p>
                </div>
            </div>
            
            <div class="border-t border-gray-100 mt-4 pt-4 flex justify-between">
                <div>
                    ${connection.status === 'completed' && !connection.buyerRating ? `
                        <button class="text-agri-primary hover:underline text-sm rate-btn" data-id="${connection.id}">
                            <i class="fas fa-star mr-1"></i> Évaluer
                        </button>
                    ` : ''}
                </div>
                
                <div class="flex space-x-2">
                    <button class="bg-green-500 hover:bg-green-600 text-white py-1 px-3 rounded-md text-sm whatsapp-btn" data-name="${connection.sellerName}">
                        <i class="fab fa-whatsapp"></i>
                    </button>
                    <button class="bg-agri-primary hover:bg-agri-primary/90 text-white py-1 px-3 rounded-md text-sm view-connection-btn" data-id="${connection.id}">
                        Détails
                    </button>
                </div>
            </div>
        `;
        
        connectionsContainer.appendChild(card);
        
        // Add event listeners
        const rateBtn = card.querySelector('.rate-btn');
        const whatsappBtn = card.querySelector('.whatsapp-btn');
        const viewBtn = card.querySelector('.view-connection-btn');
        
        if (rateBtn) {
            rateBtn.addEventListener('click', () => {
                showRatingModal(connection);
            });
        }
        
        if (whatsappBtn) {
            whatsappBtn.addEventListener('click', () => {
                const sellerName = whatsappBtn.getAttribute('data-name');
                const message = `Bonjour ${sellerName}, je vous contacte au sujet de notre mise en relation sur AgriConnect.`;
                openWhatsApp('', message);
            });
        }
        
        if (viewBtn) {
            viewBtn.addEventListener('click', () => {
                window.location.href = `connection-details.html?id=${connection.id}`;
            });
        }
    });
};

// Function to load favorites
const loadFavorites = () => {
    const favoritesContainer = document.getElementById('favorites-list');
    
    if (!favoritesContainer) {
        return;
    }
    
    // Clear container
    favoritesContainer.innerHTML = '';
    
    // Check if we have favorites
    if (mockFavorites.length === 0) {
        favoritesContainer.innerHTML = `
            <div class="text-center py-8 text-gray-500 col-span-full">
                <i class="fas fa-heart text-4xl mb-3 opacity-30"></i>
                <p>Aucun favori trouvé</p>
                <p class="text-sm mt-1">Ajoutez des produits à vos favoris</p>
            </div>
        `;
        return;
    }
    
    // Create favorite cards
    mockFavorites.forEach(favorite => {
        const card = document.createElement('div');
        card.className = 'bg-white rounded-lg shadow-sm border border-gray-100 overflow-hidden hover:shadow-md transition-shadow';
        
        // Format price
        const formattedPrice = formatCurrency(favorite.price);
        
        card.innerHTML = `
            <div class="flex">
                <div class="w-24 h-24 overflow-hidden">
                    <img 
                        src="${favorite.productImage}" 
                        alt="${favorite.productName}" 
                        class="w-full h-full object-cover"
                    />
                </div>
                <div class="p-3 flex-1">
                    <div class="flex justify-between">
                        <h3 class="font-medium line-clamp-1">${favorite.productName}</h3>
                        <button class="text-red-500 remove-favorite-btn" data-id="${favorite.id}">
                            <i class="fas fa-trash-alt"></i>
                        </button>
                    </div>
                    <p class="text-sm text-gray-500">${favorite.producerName} - ${favorite.location}</p>
                    <p class="font-bold text-agri-primary mt-1">
                        ${formattedPrice}
                        <span class="text-xs text-gray-500 ml-1">/${favorite.unit}</span>
                    </p>
                </div>
            </div>
            
            <div class="p-3 pt-0 flex justify-end space-x-2">
                <button class="bg-agri-primary/10 text-agri-primary hover:bg-agri-primary/20 py-1 px-3 rounded-md text-sm view-product-btn" data-id="${favorite.productId}">
                    Voir produit
                </button>
            </div>
        `;
        
        favoritesContainer.appendChild(card);
        
        // Add event listeners
        const removeBtn = card.querySelector('.remove-favorite-btn');
        const viewBtn = card.querySelector('.view-product-btn');
        
        if (removeBtn) {
            removeBtn.addEventListener('click', (e) => {
                e.stopPropagation();
                
                const favoriteId = removeBtn.getAttribute('data-id');
                
                // Remove from mockFavorites
                const index = mockFavorites.findIndex(f => f.id === favoriteId);
                if (index !== -1) {
                    mockFavorites.splice(index, 1);
                }
                
                // Remove card with animation
                card.classList.add('animate-fade-out');
                setTimeout(() => {
                    card.remove();
                    
                    // Check if we have favorites left
                    if (mockFavorites.length === 0) {
                        loadFavorites();
                    }
                }, 300);
                
                createToast('Produit retiré des favoris', 'info');
            });
        }
        
        if (viewBtn) {
            viewBtn.addEventListener('click', () => {
                const productId = viewBtn.getAttribute('data-id');
                window.location.href = `product-details.html?id=${productId}`;
            });
        }
    });
};

// Function to show rating modal
const showRatingModal = (connection) => {
    const modal = document.getElementById('rating-modal');
    const closeBtn = document.getElementById('close-rating-modal');
    const cancelBtn = document.getElementById('cancel-rating');
    const submitBtn = document.getElementById('submit-rating');
    const title = document.getElementById('rating-modal-title');
    
    if (!modal) {
        return;
    }
    
    // Set modal title
    if (title) {
        title.textContent = `Évaluer ${connection.sellerName}`;
    }
    
    // Show modal
    modal.classList.remove('hidden');
    
    // Initialize star rating
    initializeStarRating();
    
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
    
    // Submit button event
    if (submitBtn) {
        submitBtn.addEventListener('click', () => {
            const selectedRating = document.querySelectorAll('.star.active').length;
            const comment = document.getElementById('rating-comment')?.value || '';
            
            if (selectedRating === 0) {
                createToast('Veuillez sélectionner une note', 'error');
                return;
            }
            
            // Simulate saving rating
            setTimeout(() => {
                // Update connection in mock data
                const connectionIndex = mockConnections.findIndex(c => c.id === connection.id);
                if (connectionIndex !== -1) {
                    mockConnections[connectionIndex].buyerRating = selectedRating;
                    mockConnections[connectionIndex].buyerComment = comment;
                }
                
                createToast('Votre évaluation a été enregistrée', 'success');
                modal.classList.add('hidden');
                
                // Reload connections to update UI
                loadConnections();
            }, 500);
        });
    }
};

// Filter connections by status
const filterConnections = () => {
    const filterButtons = document.querySelectorAll('.connection-filter');
    
    filterButtons.forEach(button => {
        button.addEventListener('click', () => {
            // Remove active class from all buttons
            filterButtons.forEach(btn => btn.classList.remove('active'));
            
            // Add active class to clicked button
            button.classList.add('active');
            
            // Reload connections with filter
            loadConnections();
        });
    });
};

// Initialize dashboard
document.addEventListener('DOMContentLoaded', () => {
    loadUserData();
    loadRecentProducts();
    loadConnections();
    loadFavorites();
    filterConnections();
    
    // Initialize dashboard navigation
    initializeDashboardNav();
});