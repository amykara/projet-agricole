
/**
 * Utility functions for AgriConnect
 */

// Toast notifications
const createToast = (message, type = 'info', duration = 5000) => {
    const toastContainer = document.getElementById('toast-container');
    
    if (!toastContainer) return;
    
    const toast = document.createElement('div');
    toast.className = `toast ${type}`;
    
    toast.innerHTML = `
        <div class="toast-content">
            ${message}
        </div>
        <span class="toast-close">&times;</span>
    `;
    
    toastContainer.appendChild(toast);
    
    // Add event listener to close button
    const closeButton = toast.querySelector('.toast-close');
    closeButton.addEventListener('click', () => {
        toast.remove();
    });
    
    // Auto-remove after duration
    if (duration > 0) {
        setTimeout(() => {
            toast.remove();
        }, duration);
    }
    
    return toast;
};

// WhatsApp button utility
const openWhatsApp = (phoneNumber = '', message = '') => {
    const encodedMessage = encodeURIComponent(message);
    const whatsappUrl = phoneNumber 
        ? `https://wa.me/${phoneNumber.replace(/\D/g, '')}?text=${encodedMessage}`
        : `https://wa.me/?text=${encodedMessage}`;
    
    window.open(whatsappUrl, '_blank');
};

// Format date utility
const formatDate = (date, options = {}) => {
    if (!date) return '';
    
    const dateObj = new Date(date);
    
    const defaultOptions = {
        day: 'numeric',
        month: 'short',
        year: 'numeric',
    };
    
    const mergedOptions = { ...defaultOptions, ...options };
    
    return dateObj.toLocaleDateString('fr-FR', mergedOptions);
};

// Format currency utility
const formatCurrency = (amount, currency = 'XOF') => {
    return new Intl.NumberFormat('fr-FR', {
        style: 'currency',
        currency: currency,
        minimumFractionDigits: 0,
    }).format(amount);
};

// Truncate text utility
const truncateText = (text, maxLength) => {
    if (!text || text.length <= maxLength) {
        return text;
    }
    return text.substr(0, maxLength) + '...';
};

// Get rating stars HTML
const getRatingStarsHTML = (rating, maxRating = 5) => {
    let starsHTML = '';
    
    for (let i = 1; i <= maxRating; i++) {
        if (i <= rating) {
            starsHTML += '<i class="fas fa-star text-agri-yellow"></i>';
        } else if (i - 0.5 <= rating) {
            starsHTML += '<i class="fas fa-star-half-alt text-agri-yellow"></i>';
        } else {
            starsHTML += '<i class="far fa-star text-agri-yellow"></i>';
        }
    }
    
    return starsHTML;
};

// Get user initials from name
const getUserInitials = (name) => {
    if (!name) return '';
    
    const names = name.split(' ');
    if (names.length >= 2) {
        return (names[0][0] + names[1][0]).toUpperCase();
    }
    
    return name[0].toUpperCase();
};

// Get connection status badge HTML
const getConnectionStatusBadgeHTML = (status) => {
    let badgeClass = '';
    let badgeText = '';
    
    switch (status) {
        case 'pending':
            badgeClass = 'bg-blue-100 text-blue-800 border-blue-300';
            badgeText = 'En attente';
            break;
        case 'accepted':
            badgeClass = 'bg-green-100 text-green-800 border-green-300';
            badgeText = 'Acceptée';
            break;
        case 'completed':
            badgeClass = 'bg-purple-100 text-purple-800 border-purple-300';
            badgeText = 'Terminée';
            break;
        case 'cancelled':
            badgeClass = 'bg-red-100 text-red-800 border-red-300';
            badgeText = 'Annulée';
            break;
        default:
            badgeClass = 'bg-gray-100 text-gray-800 border-gray-300';
            badgeText = status || 'Inconnu';
    }
    
    return `<span class="${badgeClass} text-xs px-2 py-1 rounded-full border">${badgeText}</span>`;
};

// Get product status badge HTML
const getProductStatusBadgeHTML = (status) => {
    let badgeClass = '';
    let badgeText = '';
    
    switch (status) {
        case 'active':
            badgeClass = 'bg-green-100 text-green-800 border-green-300';
            badgeText = 'Disponible';
            break;
        case 'reserved':
            badgeClass = 'bg-yellow-100 text-yellow-800 border-yellow-300';
            badgeText = 'Réservé';
            break;
        case 'archived':
            badgeClass = 'bg-gray-100 text-gray-800 border-gray-300';
            badgeText = 'Archivé';
            break;
        default:
            badgeClass = 'bg-gray-100 text-gray-800 border-gray-300';
            badgeText = status || 'Inconnu';
    }
    
    return `<span class="${badgeClass} text-xs px-2 py-1 rounded-full border">${badgeText}</span>`;
};

// Handle tab functionality
const initializeTabs = () => {
    const tabHeaders = document.querySelectorAll('.tab-header');
    
    tabHeaders.forEach(header => {
        header.addEventListener('click', () => {
            // Remove active class from all headers and contents
            document.querySelectorAll('.tab-header').forEach(h => h.classList.remove('active'));
            document.querySelectorAll('.tab-content').forEach(c => c.classList.remove('active'));
            
            // Add active class to clicked header
            header.classList.add('active');
            
            // Find and show corresponding content
            const role = header.getAttribute('data-role');
            const content = document.querySelector(`.tab-content[data-role="${role}"]`);
            
            if (content) {
                content.classList.add('active');
                
                // Update hidden role input if it exists
                const roleInput = document.getElementById('role');
                if (roleInput) {
                    roleInput.value = role;
                }
                
                // Show/hide additional fields based on role
                const additionalFields = document.getElementById('additional-fields');
                const vehicleTypeContainer = document.getElementById('vehicle-type-container');
                
                if (additionalFields) {
                    if (role === 'buyer') {
                        additionalFields.classList.add('hidden');
                    } else {
                        additionalFields.classList.remove('hidden');
                        
                        if (vehicleTypeContainer) {
                            if (role === 'deliverer') {
                                vehicleTypeContainer.classList.remove('hidden');
                            } else {
                                vehicleTypeContainer.classList.add('hidden');
                            }
                        }
                        
                        // Update placeholder for bio textarea
                        const bioTextarea = document.getElementById('bio');
                        if (bioTextarea) {
                            bioTextarea.placeholder = role === 'producer' 
                                ? "Décrivez votre activité agricole..." 
                                : "Décrivez votre service de livraison...";
                        }
                    }
                }
                
                // Update submit button text based on role
                const submitButton = document.getElementById('register-submit');
                if (submitButton) {
                    submitButton.textContent = role === 'buyer' 
                        ? "Créer mon compte" 
                        : "Soumettre ma demande";
                    
                    // Also update button color based on role
                    submitButton.className = 'py-2 px-4 rounded-md transition-colors duration-200 font-medium w-full';
                    
                    if (role === 'buyer') {
                        submitButton.classList.add('bg-agri-primary', 'hover:bg-agri-primary/90', 'text-white');
                    } else if (role === 'producer') {
                        submitButton.classList.add('bg-agri-secondary', 'hover:bg-agri-secondary/90', 'text-white');
                    } else if (role === 'deliverer') {
                        submitButton.classList.add('bg-agri-accent', 'hover:bg-agri-accent/90', 'text-white');
                    }
                }
            }
        });
    });
};

// Handle dashboard navigation
const initializeDashboardNav = () => {
    const navLinks = document.querySelectorAll('.dashboard-nav-link');
    
    navLinks.forEach(link => {
        link.addEventListener('click', (e) => {
            e.preventDefault();
            
            // Remove active class from all links
            document.querySelectorAll('.dashboard-nav-link').forEach(l => l.classList.remove('active'));
            
            // Add active class to clicked link
            link.classList.add('active');
            
            // Hide all sections
            document.querySelectorAll('.dashboard-section').forEach(s => s.classList.add('hidden'));
            
            // Show the corresponding section
            const sectionId = link.getAttribute('href').replace('#', '');
            const section = document.getElementById(`${sectionId}-section`);
            
            if (section) {
                section.classList.remove('hidden');
                section.classList.add('active');
            }
        });
    });
};

// Initialize accordion functionality
const initializeAccordions = () => {
    const accordionItems = document.querySelectorAll('.accordion-header');
    
    accordionItems.forEach(item => {
        item.addEventListener('click', () => {
            const content = item.nextElementSibling;
            const icon = item.querySelector('.accordion-icon');
            
            // Toggle active class
            content.classList.toggle('active');
            icon?.classList.toggle('active');
            
            // Update aria-expanded
            const expanded = content.classList.contains('active');
            item.setAttribute('aria-expanded', expanded);
        });
    });
};

// Handle mobile menu
const initializeMobileMenu = () => {
    const menuBtn = document.getElementById('mobile-menu-btn');
    const mobileMenu = document.getElementById('mobile-menu');
    
    if (menuBtn && mobileMenu) {
        menuBtn.addEventListener('click', () => {
            mobileMenu.classList.toggle('hidden');
            
            // Toggle icon
            const icon = menuBtn.querySelector('i');
            if (icon) {
                if (mobileMenu.classList.contains('hidden')) {
                    icon.className = 'fas fa-bars';
                } else {
                    icon.className = 'fas fa-times';
                }
            }
        });
    }
};

// Initialize star rating
const initializeStarRating = () => {
    const stars = document.querySelectorAll('.star-rating .star');
    const submitRatingButton = document.getElementById('submit-rating');
    
    let selectedRating = 0;
    
    stars.forEach((star, index) => {
        const starValue = index + 1;
        
        star.addEventListener('mouseover', () => {
            stars.forEach((s, i) => {
                if (i <= index) {
                    s.classList.add('active');
                } else {
                    s.classList.remove('active');
                }
            });
        });
        
        star.addEventListener('mouseout', () => {
            stars.forEach((s, i) => {
                if (i < selectedRating) {
                    s.classList.add('active');
                } else {
                    s.classList.remove('active');
                }
            });
        });
        
        star.addEventListener('click', () => {
            selectedRating = starValue;
            
            stars.forEach((s, i) => {
                if (i < selectedRating) {
                    s.classList.add('active');
                } else {
                    s.classList.remove('active');
                }
            });
            
            // Enable submit button if rating is selected
            if (submitRatingButton) {
                submitRatingButton.disabled = false;
            }
        });
    });
};


