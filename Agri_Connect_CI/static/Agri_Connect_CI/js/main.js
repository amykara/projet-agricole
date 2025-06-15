

// Détermine le nombre de cartes visibles selon la largeur d'écran
function getVisibleCardsCount() {
    const width = window.innerWidth;
    if (width < 576) return 1;
    if (width < 992) return 2;
    return 3;
}


   

    // Fonction pour faire défiler les profils
    function setupScroll(containerId, prevButtonClass, nextButtonClass) {
      const container = document.getElementById(containerId);
      const prevButton = document.querySelector(`.${prevButtonClass}`);
      const nextButton = document.querySelector(`.${nextButtonClass}`);
      
      const cardWidth = container.querySelector('.profile-card').offsetWidth + 24; // 24 = gap
      const scrollAmount = cardWidth * 3; // Faire défiler 3 cartes à la fois
      
      prevButton.addEventListener('click', () => {
        container.scrollBy({ left: -scrollAmount, behavior: 'smooth' });
      });
      
      nextButton.addEventListener('click', () => {
        container.scrollBy({ left: scrollAmount, behavior: 'smooth' });
      });
      
      // Désactiver les boutons si nécessaire
      container.addEventListener('scroll', () => {
        prevButton.disabled = container.scrollLeft <= 10;
        nextButton.disabled = container.scrollLeft >= container.scrollWidth - container.clientWidth - 10;
      });
    }

    // Charger les données
    document.addEventListener('DOMContentLoaded', () => {
      const livreursContainer = document.getElementById('livreurs-container');
      const producteursContainer = document.getElementById('producteurs-container');
      
      // Ajouter les livreurs
      livreursData.forEach(livreur => {
        livreursContainer.appendChild(createProfileCard(livreur, 'livreur'));
      });
      
      // Ajouter les producteurs
      producteursData.forEach(producteur => {
        producteursContainer.appendChild(createProfileCard(producteur, 'producteur'));
      });
      
      // Configurer le défilement
      setupScroll('livreurs-container', 'prev-livreur', 'next-livreur');
      setupScroll('producteurs-container', 'prev-producteur', 'next-producteur');
      
      // Initialiser les icônes
      lucide.createIcons();
      
      // Désactiver les boutons précédents au chargement
      document.querySelectorAll('.prev-livreur, .prev-producteur').forEach(btn => {
        btn.disabled = true;
      });
    });
  
  







        