from django import forms
from django.contrib.auth.forms import UserCreationForm
from .models import *
from django.contrib.auth.forms import AuthenticationForm
from django.contrib.auth.forms import UserCreationForm
from django.core.exceptions import ValidationError
from .models import Utilisateur, TypeContact, Contact
from django.forms.widgets import ClearableFileInput
import datetime

class MultiFileClearableInput(ClearableFileInput):
    """
    Version de ClearableFileInput qui accepte plusieurs fichiers.
    """
    allow_multiple_selected = True


class InscriptionForm(UserCreationForm):


    email = forms.EmailField(
        label="Email",
        required=True,
        widget=forms.EmailInput(attrs={
            'class': 'form-input',
            'placeholder': 'votre@email.com',
            'id': 'id_email'
        })
    )
    
    phone = forms.CharField(
        label="Téléphone",
        required=True,
        widget=forms.TextInput(attrs={
            'class': 'form-input',
            'placeholder': '+2250102030405',
            'id': 'id_phone'
        })
    )

    class Meta:
        model = Utilisateur
        fields = ('username', 'full_name', 'email', 'phone', 'password1', 'password2')
        widgets = {
            'username': forms.TextInput(attrs={
                'class': 'form-input',
                'placeholder': 'johndoe',
                'id': 'id_username'
            }),
            'full_name': forms.TextInput(attrs={
                'class': 'form-input',
                'placeholder': 'Jean Dupont',
                'id': 'id_full_name'
            }),
        }

    def clean_username(self):
        username = self.cleaned_data.get('username')
        if ' ' in username:
            raise ValidationError("Le nom d'utilisateur ne doit pas contenir d'espaces")
        return username.lower()

    def clean_email(self):
        email = self.cleaned_data.get('email').lower()
        email_type = TypeContact.objects.filter(nom='Email').first()
        if email_type:
            if Contact.objects.filter(type_contact=email_type, valeur=email).exists():
                raise ValidationError("Cet email est déjà utilisé")
        return email

    def clean_phone(self):
        phone = self.cleaned_data.get('phone')
        if not phone.startswith('+'):
            raise ValidationError("Le numéro doit commencer par l'indicatif pays (ex: +225)")
        return phone
    
 
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        # Simplifier les exigences du mot de passe
        self.fields['password1'].help_text = "Votre mot de passe doit contenir au moins 8 caractères."
        self.fields['password2'].help_text = "Entrez le même mot de passe pour vérification."
        
        self.fields['password1'].widget.attrs.update({
            'class': 'form-input',
            'placeholder': '8 caractères minimum',
            'minlength': '8',
            'id': 'id_password1'
        })
        self.fields['password2'].widget.attrs.update({
            'class': 'form-input',
            'placeholder': 'Confirmez votre mot de passe',
            'id': 'id_password2'
        })

    def clean_password1(self):
        password1 = self.cleaned_data.get('password1')
        if len(password1) < 8:
            raise ValidationError("Le mot de passe doit contenir au moins 8 caractères.")
        return password1

    def save(self, commit=True):
        user = super().save(commit=False)
        
        if commit:
            user.save()
            
            # Création des contacts
            email_type, _ = TypeContact.objects.get_or_create(nom='Email')
            phone_type, _ = TypeContact.objects.get_or_create(nom='Téléphone')
            
            Contact.objects.create(
                utilisateur=user,
                type_contact=email_type,
                valeur=self.cleaned_data['email']
            )
            
            Contact.objects.create(
                utilisateur=user,
                type_contact=phone_type,
                valeur=self.cleaned_data['phone']
            )
        
        return user


class ConnexionForm(AuthenticationForm):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.fields['username'].widget.attrs.update({
            'placeholder': 'Nom d\'utilisateur',
            'class': 'form-input'
        })
        self.fields['password'].widget.attrs.update({
            'placeholder': 'Mot de passe',
            'class': 'form-input'
        })

    def confirm_login_allowed(self, user):
        if not user.is_active:
            raise forms.ValidationError("Ce compte est désactivé.", code='inactive')
        





class ProfileForm(forms.ModelForm):
    class Meta:
        model = Utilisateur
        fields = ['username', 'full_name', 'photo_profil']
        labels = {
            'username': "Nom d'utilisateur",
            'full_name': "Nom complet",
            'photo_profil': "Photo de profil"
        }
        widgets = {
            'photo_profil': forms.FileInput(attrs={'accept': 'image/*'})
        }

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.fields['username'].required = True
        self.fields['full_name'].required = True



class AnnonceLivreurForm(forms.ModelForm):
    class Meta:
        model = Annonce
        fields = ['titre', 'description', 'zone']
        widgets = {
            'description': forms.Textarea(attrs={'rows': 4}),
        }

    # Ajoutez des champs pour les produits si nécessaire
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.fields['zone'].queryset = Zone.objects.all()        




class AnnonceProduitForm(forms.ModelForm):
    produit_suggestion = forms.CharField(
        required=False,
        widget=forms.TextInput(attrs={
            'class': 'form-control',
            'placeholder': 'Rechercher un produit existant...',
            'autocomplete': 'off'
        }),
        label="Rechercher un produit"
    )
    
    class Meta:
        model = AnnonceProduit
        fields = ['nom_produit', 'categorie', 'unite', 'quantite', 
                 'prix_unitaire', 'devise', 'conditionnement', 'certification']
        widgets = {
            'nom_produit': forms.TextInput(attrs={
                'class': 'form-control',
                'placeholder': 'Ou saisissez un nouveau produit'
            }),
            'certification': forms.Select(attrs={'class': 'form-control'})
        }

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.fields['certification'].required = False
        self.fields['certification'].empty_label = "Sans certification"

    def clean_quantite(self):
        quantite = self.cleaned_data.get('quantite')
        if quantite <= 0:
            raise ValidationError("La quantité doit être positive")
        return quantite

    def clean_prix_unitaire(self):
        prix = self.cleaned_data.get('prix_unitaire')
        if prix <= 0:
            raise ValidationError("Le prix doit être positif")
        return prix

class AnnonceAutreForm(forms.ModelForm):
    photo = forms.ImageField(required=False)
    
    class Meta:
        model = Annonce
        fields = ['type_annonce', 'titre', 'description']
        widgets = {
            'type_annonce': forms.Select(attrs={'class': 'form-control'}),
            'titre': forms.TextInput(attrs={'class': 'form-control'}),
            'description': forms.Textarea(attrs={'class': 'form-control', 'rows': 5}),
        }

    def clean_titre(self):
        titre = self.cleaned_data.get('titre')
        if len(titre) < 10:
            raise ValidationError("Le titre doit faire au moins 10 caractères")
        return titre


from django.core.validators import FileExtensionValidator

class InscriptionProducteurForm(forms.Form):
    METHODES_PRODUCTION = [
        ('bio', 'Bio'),
        ('conventionnel', 'Conventionnel'),
        ('permaculture', 'Permaculture'),
        ('autre', 'Autre')
    ]

    # Informations personnelles (Utilisateur)
    username = forms.CharField(
        label="Nom d'utilisateur",
        max_length=30,
        required=False,
        help_text="Requis. 30 caractères maximum. Lettres, chiffres et @/./+/-/_ uniquement."
    )
    email = forms.EmailField(label="Email", required=True)
    full_name = forms.CharField(label="Nom complet", max_length=100, required=True)
    zone = forms.ModelChoiceField(
        label="Zone de résidence",
        queryset=Zone.objects.all(),
        required=True
    )
    photo_profil = forms.ImageField(
        label="Photo de profil",
        required=False,
        validators=[FileExtensionValidator(allowed_extensions=['jpg', 'jpeg', 'png'])]
    )
    
    # Contacts (téléphone et WhatsApp)
    telephone = forms.CharField(label="Téléphone", max_length=20, required=True)
    whatsapp = forms.CharField(
        label="WhatsApp", 
        max_length=20, 
        required=False,
        help_text="Optionnel - Si différent du téléphone"
    )
    
    # Mot de passe (uniquement pour nouveaux utilisateurs)
    password = forms.CharField(
        label="Mot de passe", 
        widget=forms.PasswordInput, 
        required=False,
        help_text="Minimum 8 caractères"
    )
    confirm_password = forms.CharField(
        label="Confirmer le mot de passe", 
        widget=forms.PasswordInput, 
        required=False
    )
    
    # Informations producteur (Producteur)
    date_debut_activite = forms.DateField(
        label="Date de début d'activité",
        widget=forms.DateInput(attrs={'type': 'date'}),
        required=True
    )
    methode_production = forms.ChoiceField(
        label="Méthode de production",
        choices=METHODES_PRODUCTION,
        required=True
    )
    description_longue = forms.CharField(
        label="Description de votre activité",
        widget=forms.Textarea,
        required=True
    )
    specialites = forms.CharField(
        label="Spécialités",
        max_length=255,
        required=False,
        help_text="Séparées par des virgules (ex: Fruits, Légumes)"
    )
    
    # Documents
    cni_recto = forms.FileField(
        label="CNI (Recto)",
        required=True,
        validators=[FileExtensionValidator(allowed_extensions=['jpg', 'jpeg', 'png', 'pdf'])]
    )
    cni_verso = forms.FileField(
        label="CNI (Verso)",
        required=False,
        validators=[FileExtensionValidator(allowed_extensions=['jpg', 'jpeg', 'png', 'pdf'])]
    )
    photos_ferme = forms.FileField(
    label="Photos de votre ferme (max 5)",
    required=False,
    widget=MultiFileClearableInput(attrs={'multiple': True}),
    validators=[FileExtensionValidator(allowed_extensions=['jpg', 'jpeg', 'png'])],
)

    
    # Conditions
    accept_conditions = forms.BooleanField(
        label="J'accepte les conditions générales",
        required=True
    )

    def __init__(self, *args, user_exists=False, **kwargs):
        self.user_exists = user_exists
        initial = kwargs.pop('initial', {})
        super().__init__(*args, **kwargs)
        
        if user_exists:
            self.fields['password'].required = False
            self.fields['confirm_password'].required = False
            self.fields['username'].widget.attrs['readonly'] = True

    def clean_photos_ferme(self):
        photos = self.files.getlist('photos_ferme')
        if len(photos) > 5:
            raise ValidationError("Vous ne pouvez uploader que 5 photos maximum.")
        return photos        

    def clean(self):
        cleaned_data = super().clean()
        
        # Validation mot de passe pour nouveaux utilisateurs
        if not self.user_exists:
            password = cleaned_data.get('password')
            confirm_password = cleaned_data.get('confirm_password')
            
            if not password:
                self.add_error('password', "Ce champ est obligatoire.")
            elif len(password) < 8:
                self.add_error('password', "Le mot de passe doit contenir au moins 8 caractères.")
            
            if password and confirm_password and password != confirm_password:
                self.add_error('confirm_password', "Les mots de passe ne correspondent pas.")
            
            if not cleaned_data.get('username'):
                self.add_error('username', "Ce champ est obligatoire.")

        return cleaned_data
    

class LivreurForm(forms.ModelForm):
    full_name = forms.CharField(label="Nom complet", required=True)
    email = forms.EmailField(label="Email", required=True)
    telephone = forms.CharField(label="Téléphone", required=True)
    photo_profil = forms.ImageField(label="Photo de profil", required=False)

    zones = forms.ModelMultipleChoiceField(
        queryset=Zone.objects.all(),
        widget=forms.CheckboxSelectMultiple,
        required=False
    )

    jours_disponibilite = forms.MultipleChoiceField(
        choices=DisponibiliteLivreur.JOURS,
        widget=forms.CheckboxSelectMultiple,
        required=False,
        label="Jours de disponibilité"
    )

    heure_debut = forms.TimeField(label="Heure de début", required=False)
    heure_fin = forms.TimeField(label="Heure de fin", required=False)

    class Meta:
        model = Livreur
        fields = [
            'type_livreur',
            'description',
            'etat',
            'tarif',
        ]
        widgets = {
            'description': forms.Textarea(attrs={'rows': 4}),
        }

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)

        if self.instance.pk:
            # Pré-remplir les zones
            self.fields['zones'].initial = Zone.objects.filter(
                livreurzone__livreur=self.instance
            )

            # Pré-remplir disponibilités
            disponibilites = DisponibiliteLivreur.objects.filter(livreur=self.instance)
            if disponibilites.exists():
                self.fields['jours_disponibilite'].initial = [
                    d.jour_semaine for d in disponibilites
                ]
                self.fields['heure_debut'].initial = disponibilites.first().date_debut.time()
                self.fields['heure_fin'].initial = disponibilites.first().date_fin.time()

            # Pré-remplir infos utilisateur
            self.fields['full_name'].initial = self.instance.utilisateur.full_name
            self.fields['email'].initial = self.instance.utilisateur.get_email()
            self.fields['photo_profil'].initial = self.instance.utilisateur.photo_profil

    def save(self, commit=True):
        livreur = super().save(commit=False)
        data = self.cleaned_data

        # Mise à jour de l'utilisateur lié
        utilisateur = livreur.utilisateur
        utilisateur.full_name = data.get('full_name')
        if data.get('photo_profil'):
            utilisateur.photo_profil = data.get('photo_profil')
        utilisateur.save()

        # Enregistrer le livreur
        if commit:
            livreur.save()

        # Zones
        LivreurZone.objects.filter(livreur=livreur).delete()
        for zone in data.get('zones', []):
            LivreurZone.objects.create(livreur=livreur, zone=zone)

        # Disponibilités
        DisponibiliteLivreur.objects.filter(livreur=livreur).delete()
        for jour in data.get('jours_disponibilite', []):
            DisponibiliteLivreur.objects.create(
                livreur=livreur,
                jour_semaine=jour,
                date_debut=timezone.make_aware(
                    datetime.combine(timezone.now().date(), data['heure_debut'])
                ),
                date_fin=timezone.make_aware(
                    datetime.combine(timezone.now().date(), data['heure_fin'])
                ),
                statut='disponible'
            )

        return livreur
