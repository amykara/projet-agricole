
document.addEventListener('DOMContentLoaded', function() {
    // Gestion des onglets FAQ
    const tabs = document.querySelectorAll('.faq-tab');
    const tabContents = document.querySelectorAll('.faq-tab-content');
    
    tabs.forEach(tab => {
        tab.addEventListener('click', () => {
            const target = tab.getAttribute('data-target');
            
            // Désactivation de tous les onglets et contenus
            tabs.forEach(t => t.classList.remove('active'));
            tabContents.forEach(content => content.classList.remove('active'));
            
            // Activation de l'onglet cliqué et de son contenu
            tab.classList.add('active');
            document.getElementById(target).classList.add('active');
        });
    });
    
    // Gestion des accordéons
    const accordionItems = document.querySelectorAll('.accordion-item');
    
    accordionItems.forEach(item => {
        const header = item.querySelector('.accordion-header');
        const content = item.querySelector('.accordion-content');
        const icon = item.querySelector('.accordion-icon i');
        
        header.addEventListener('click', () => {
            const isActive = item.classList.contains('active');
            
            // Fermer tous les items actifs
            accordionItems.forEach(i => {
                i.classList.remove('active');
                i.querySelector('.accordion-icon i').classList.remove('fa-minus');
                i.querySelector('.accordion-icon i').classList.add('fa-plus');
            });
            
            // Si l'item n'était pas actif, l'activer
            if (!isActive) {
                item.classList.add('active');
                icon.classList.remove('fa-plus');
                icon.classList.add('fa-minus');
            }
        });
    });

    // Gestion du formulaire de contact
    const contactForm = document.getElementById('contact-form');
    
    if (contactForm) {
        contactForm.addEventListener('submit', function(e) {
            e.preventDefault();
            
            // Simuler l'envoi du formulaire
            const name = document.getElementById('name').value;
            const email = document.getElementById('email').value;
            const subject = document.getElementById('subject').value;
            const message = document.getElementById('message').value;
            
            // Vérification simple
            if (name && email && subject && message) {
                // Dans un cas réel, vous enverriez ces données à un serveur
                console.log('Formulaire soumis avec les données:', { name, email, subject, message });
                
                // Afficher une notification toast
                showToast('success', 'Votre message a été envoyé avec succès. Nous vous répondrons dans les plus brefs délais.');
                
                // Réinitialiser le formulaire
                contactForm.reset();
            } else {
                showToast('error', 'Veuillez remplir tous les champs du formulaire.');
            }
        });
    }

    // Fonction pour afficher les notifications toast (réutilisation du code de main.js)
    function showToast(type, message) {
        const toast = document.getElementById('toast');
        const toastMessage = document.querySelector('.toast-message');
        const toastIcon = document.querySelector('.toast-icon');
        
        // Définir le message
        toastMessage.textContent = message;
        
        // Définir l'icône en fonction du type
        if (type === 'success') {
            toastIcon.className = 'fas fa-check-circle toast-icon';
            toast.style.borderLeft = '4px solid var(--color-success)';
            toastIcon.style.color = 'var(--color-success)';
        } else if (type === 'error') {
            toastIcon.className = 'fas fa-exclamation-circle toast-icon';
            toast.style.borderLeft = '4px solid var(--color-danger)';
            toastIcon.style.color = 'var(--color-danger)';
        } else if (type === 'warning') {
            toastIcon.className = 'fas fa-exclamation-triangle toast-icon';
            toast.style.borderLeft = '4px solid var(--color-warning)';
            toastIcon.style.color = 'var(--color-warning)';
        }
        
        // Afficher le toast
        toast.classList.add('show');
        
        // Masquer le toast après 5 secondes
        setTimeout(() => {
            toast.classList.remove('show');
        }, 5000);
    }
    
    // Gestionnaire pour le bouton de fermeture du toast
    const toastCloseButton = document.querySelector('.toast-close');
    if (toastCloseButton) {
        toastCloseButton.addEventListener('click', function() {
            document.getElementById('toast').classList.remove('show');
        });
    }
});
