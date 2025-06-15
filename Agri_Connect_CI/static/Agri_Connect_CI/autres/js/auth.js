
/**
 * Authentication related functionality for AgriConnect
 */

// Mock user data for demo purposes
const mockUsers = [
    {
        id: '1',
        name: 'John Buyer',
        email: 'buyer@example.com',
        password: 'password',
        role: 'buyer',
        isVerified: true,
        avatar: null,
        location: 'Dakar',
        phone: '+221 77 123 4567',
        bio: 'Regular buyer of fresh products',
        rating: 4.5,
        createdAt: new Date('2023-01-15'),
    },
    {
        id: '2',
        name: 'Marie Producteur',
        email: 'producer@example.com',
        password: 'password',
        role: 'producer',
        isVerified: true,
        avatar: null,
        location: 'Thiès',
        phone: '+221 76 765 4321',
        bio: 'Organic vegetable farmer for 10 years',
        rating: 4.8,
        createdAt: new Date('2022-11-03'),
    },
    {
        id: '3',
        name: 'Demba Delivery',
        email: 'delivery@example.com',
        password: 'password',
        role: 'deliverer',
        isVerified: true,
        avatar: null,
        location: 'Saint-Louis',
        phone: '+221 78 987 6543',
        bio: 'Reliable delivery service with van',
        rating: 4.6,
        vehicleType: 'van',
        createdAt: new Date('2023-02-20'),
    },
    {
        id: '4',
        name: 'Admin User',
        email: 'admin@example.com',
        password: 'password',
        role: 'admin',
        isVerified: true,
        avatar: null,
        createdAt: new Date('2022-01-01'),
    },
];

// Check if user is logged in
const checkAuth = () => {
    const userData = localStorage.getItem('agriUser');
    if (!userData) {
        return null;
    }
    
    try {
        return JSON.parse(userData);
    } catch (error) {
        console.error('Error parsing user data:', error);
        return null;
    }
};

// Update navbar based on authentication state
const updateNavbar = () => {
    const currentUser = checkAuth();
    const userMenuContainer = document.getElementById('user-menu-container');
    const authButtons = document.getElementById('auth-buttons');
    const mobileUserMenu = document.getElementById('mobile-user-menu');
    const mobileAuthButtons = document.getElementById('mobile-auth-buttons');
    
    if (!userMenuContainer || !authButtons) {
        return;
    }
    
    if (currentUser) {
        // User is logged in, show user menu
        authButtons.classList.add('hidden');
        userMenuContainer.classList.remove('hidden');
        
        // Create user dropdown menu
        userMenuContainer.innerHTML = `
            <div class="relative">
                <button id="user-dropdown-btn" class="flex items-center space-x-2">
                    <div class="w-8 h-8 rounded-full bg-${getUserRoleColor(currentUser.role)} flex items-center justify-center text-white">
                        ${getUserInitials(currentUser.name)}
                    </div>
                    <span class="hidden lg:block">${currentUser.name}</span>
                    <i class="fas fa-chevron-down text-xs"></i>
                </button>
                
                <div id="user-dropdown-menu" class="absolute right-0 mt-2 w-48 bg-white rounded-md shadow-lg py-1 z-20 hidden">
                    <a href="dashboard-${currentUser.role}.html" class="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-100">
                        <i class="fas fa-tachometer-alt mr-2"></i> Tableau de bord
                    </a>
                    <a href="profile.html" class="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-100">
                        <i class="fas fa-user mr-2"></i> Mon profil
                    </a>
                    <a href="connections.html" class="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-100">
                        <i class="fas fa-exchange-alt mr-2"></i> Mes mises en relation
                    </a>
                    <div class="border-t border-gray-100 my-1"></div>
                    <button id="logout-btn" class="block w-full text-left px-4 py-2 text-sm text-red-600 hover:bg-gray-100">
                        <i class="fas fa-sign-out-alt mr-2"></i> Déconnexion
                    </button>
                </div>
            </div>
        `;
        
        // Setup dropdown toggle
        const dropdownBtn = document.getElementById('user-dropdown-btn');
        const dropdownMenu = document.getElementById('user-dropdown-menu');
        
        if (dropdownBtn && dropdownMenu) {
            dropdownBtn.addEventListener('click', () => {
                dropdownMenu.classList.toggle('hidden');
            });
            
            // Close dropdown when clicking elsewhere
            document.addEventListener('click', (e) => {
                if (!dropdownBtn.contains(e.target) && !dropdownMenu.contains(e.target)) {
                    dropdownMenu.classList.add('hidden');
                }
            });
        }
        
        // Setup logout button
        const logoutBtn = document.getElementById('logout-btn');
        if (logoutBtn) {
            logoutBtn.addEventListener('click', () => {
                logout();
            });
        }
        
        // Update mobile menu
        if (mobileUserMenu && mobileAuthButtons) {
            mobileAuthButtons.classList.add('hidden');
            mobileUserMenu.classList.remove('hidden');
            
            mobileUserMenu.innerHTML = `
                <div class="border-t border-agri-gray/20 pt-4">
                    <div class="px-4 py-2 flex items-center">
                        <div class="w-10 h-10 rounded-full bg-${getUserRoleColor(currentUser.role)} flex items-center justify-center text-white font-bold mr-3">
                            ${getUserInitials(currentUser.name)}
                        </div>
                        <div>
                            <p class="font-medium">${currentUser.name}</p>
                            <p class="text-sm text-muted-foreground">${currentUser.email}</p>
                        </div>
                    </div>
                    
                    <a href="dashboard-${currentUser.role}.html" class="px-4 py-2 hover:bg-agri-light rounded-md flex items-center">
                        <i class="fas fa-tachometer-alt mr-2"></i>
                        <span>Tableau de bord</span>
                    </a>
                    
                    <a href="profile.html" class="px-4 py-2 hover:bg-agri-light rounded-md flex items-center">
                        <i class="fas fa-user mr-2"></i>
                        <span>Mon profil</span>
                    </a>
                    
                    <a href="connections.html" class="px-4 py-2 hover:bg-agri-light rounded-md flex items-center">
                        <i class="fas fa-exchange-alt mr-2"></i>
                        <span>Mes mises en relation</span>
                    </a>
                    
                    <button 
                        id="mobile-logout-btn"
                        class="w-full text-left px-4 py-2 hover:bg-agri-light rounded-md flex items-center text-red-500"
                    >
                        <i class="fas fa-sign-out-alt mr-2"></i>
                        <span>Déconnexion</span>
                    </button>
                </div>
            `;
            
            // Setup mobile logout button
            const mobileLogoutBtn = document.getElementById('mobile-logout-btn');
            if (mobileLogoutBtn) {
                mobileLogoutBtn.addEventListener('click', () => {
                    logout();
                });
            }
        }
    } else {
        // User is not logged in, show auth buttons
        userMenuContainer.classList.add('hidden');
        authButtons.classList.remove('hidden');
        
        // Update mobile menu
        if (mobileUserMenu && mobileAuthButtons) {
            mobileUserMenu.classList.add('hidden');
            mobileAuthButtons.classList.remove('hidden');
        }
    }
};

// Logout function
const logout = () => {
    localStorage.removeItem('agriUser');
    createToast('Vous avez été déconnecté avec succès', 'success');
    
    // Redirect to home page after logout
    setTimeout(() => {
        window.location.href = 'index.html';
    }, 1000);
};

// Get user role color
const getUserRoleColor = (role) => {
    switch (role) {
        case 'buyer':
            return 'agri-primary';
        case 'producer':
            return 'agri-secondary';
        case 'deliverer':
            return 'agri-accent';
        case 'admin':
            return 'red-600';
        default:
            return 'gray-500';
    }
};

// Handle login form submission
const handleLogin = (e) => {
    e.preventDefault();
    
    const emailInput = document.getElementById('email');
    const passwordInput = document.getElementById('password');
    const roleSelect = document.getElementById('role');
    
    if (!emailInput || !passwordInput || !roleSelect) {
        return;
    }
    
    const email = emailInput.value.trim();
    const password = passwordInput.value.trim();
    const role = roleSelect.value;
    
    if (!email || !password) {
        createToast('Veuillez remplir tous les champs', 'error');
        return;
    }
    
    // Simulate API call
    setTimeout(() => {
        // Find user by email and role
        const user = mockUsers.find(u => u.email === email && u.role === role);
        
        if (user && user.password === password) {
            // Successful login
            const { password, ...userData } = user; // Remove password from user data
            localStorage.setItem('agriUser', JSON.stringify(userData));
            
            createToast('Connexion réussie', 'success');
            
            // Redirect based on role
            setTimeout(() => {
                window.location.href = `dashboard-${role}.html`;
            }, 1000);
        } else {
            // Failed login
            createToast('Email ou mot de passe incorrect', 'error');
        }
    }, 1000);
};

// Handle registration form submission
const handleRegistration = (e) => {
    e.preventDefault();
    
    const nameInput = document.getElementById('name');
    const emailInput = document.getElementById('register-email');
    const passwordInput = document.getElementById('register-password');
    const confirmPasswordInput = document.getElementById('confirm-password');
    const roleInput = document.getElementById('role');
    
    if (!nameInput || !emailInput || !passwordInput || !confirmPasswordInput || !roleInput) {
        return;
    }
    
    const name = nameInput.value.trim();
    const email = emailInput.value.trim();
    const password = passwordInput.value.trim();
    const confirmPassword = confirmPasswordInput.value.trim();
    const role = roleInput.value;
    
    if (!name || !email || !password || !confirmPassword) {
        createToast('Veuillez remplir tous les champs obligatoires', 'error');
        return;
    }
    
    if (password !== confirmPassword) {
        createToast('Les mots de passe ne correspondent pas', 'error');
        return;
    }
    
    // Additional validation for producer/deliverer
    if (role !== 'buyer') {
        const locationInput = document.getElementById('location');
        const phoneInput = document.getElementById('phone');
        
        if (!locationInput || !phoneInput) {
            return;
        }
        
        const location = locationInput.value.trim();
        const phone = phoneInput.value.trim();
        
        if (!location || !phone) {
            createToast('Veuillez remplir tous les champs obligatoires', 'error');
            return;
        }
        
        // Validation for deliverer
        if (role === 'deliverer') {
            const vehicleTypeSelect = document.getElementById('vehicle-type');
            
            if (!vehicleTypeSelect) {
                return;
            }
            
            const vehicleType = vehicleTypeSelect.value;
            
            if (!vehicleType) {
                createToast('Veuillez sélectionner un type de véhicule', 'error');
                return;
            }
        }
    }
    
    // Simulate API call
    setTimeout(() => {
        // Check if email is already used
        const existingUser = mockUsers.find(u => u.email === email);
        
        if (existingUser) {
            createToast('Cet email est déjà utilisé', 'error');
            return;
        }
        
        // Create new user
        const newUser = {
            id: `user_${Date.now()}`,
            name,
            email,
            password,
            role,
            isVerified: role === 'buyer', // Only buyers are auto-verified
            avatar: null,
            createdAt: new Date()
        };
        
        // Add additional fields for producer/deliverer
        if (role !== 'buyer') {
            newUser.location = document.getElementById('location').value.trim();
            newUser.phone = document.getElementById('phone').value.trim();
            newUser.bio = document.getElementById('bio')?.value.trim() || '';
            
            if (role === 'deliverer') {
                newUser.vehicleType = document.getElementById('vehicle-type').value;
            }
        }
        
        // Add to mock users
        mockUsers.push(newUser);
        
        // Automatic login for buyers, otherwise show pending message
        if (role === 'buyer') {
            const { password, ...userData } = newUser; // Remove password
            localStorage.setItem('agriUser', JSON.stringify(userData));
            
            createToast('Inscription réussie', 'success');
            
            setTimeout(() => {
                window.location.href = `dashboard-${role}.html`;
            }, 1000);
        } else {
            createToast('Votre demande a été soumise et est en attente de vérification', 'info');
            
            setTimeout(() => {
                window.location.href = 'registration-pending.html';
            }, 2000);
        }
    }, 1000);
};

// Handle demo login button
const handleDemoLogin = () => {
    const roleSelect = document.getElementById('role');
    const emailInput = document.getElementById('email');
    const passwordInput = document.getElementById('password');
    
    if (!roleSelect || !emailInput || !passwordInput) {
        return;
    }
    
    const role = roleSelect.value;
    
    // Find demo user for selected role
    const demoUser = mockUsers.find(u => u.role === role);
    
    if (demoUser) {
        emailInput.value = demoUser.email;
        passwordInput.value = demoUser.password;
    }
};

// Initialize authentication related functionality
const initializeAuth = () => {
    // Update navbar based on auth state
    updateNavbar();
    
    // Set up login form if present
    const loginForm = document.getElementById('login-form');
    if (loginForm) {
        loginForm.addEventListener('submit', handleLogin);
    }
    
    // Set up register form if present
    const registerForm = document.getElementById('register-form');
    if (registerForm) {
        registerForm.addEventListener('submit', handleRegistration);
    }
    
    // Set up demo login button if present
    const demoAccountBtn = document.getElementById('demo-account-btn');
    if (demoAccountBtn) {
        demoAccountBtn.addEventListener('click', handleDemoLogin);
    }
    
    // Check URL parameters for role selection in registration
    
};

// Run when DOM is loaded
document.addEventListener('DOMContentLoaded', () => {
    initializeAuth();
    initializeMobileMenu();
});
