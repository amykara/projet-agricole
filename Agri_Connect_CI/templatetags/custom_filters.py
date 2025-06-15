from django import template
from ..models import Contact, TypeContact

register = template.Library()

@register.filter
def first_letters(value):
    """Returns the first letters of each word in a string"""
    if not value:
        return ""
    return "".join(word[0].upper() for word in value.split() if word)



@register.filter
def get_range(value):
    return range(1, value + 1)

@register.filter
def get_item(dictionary, key):
    return dictionary.get(key)

@register.filter
def get_contact(contacts, contact_type):
    return contacts.filter(type_contact__nom=contact_type).first()

@register.filter
def get_contact(contacts, type_name):
    """Filtre pour récupérer un contact spécifique par type"""
    try:
        type_contact = TypeContact.objects.get(nom=type_name)
        contact = contacts.get(type_contact=type_contact)
        return contact
    except (TypeContact.DoesNotExist, Contact.DoesNotExist):
        return None
    
@register.filter
def filter_type_contact(contacts, type_name):
    return contacts.filter(type_contact__nom=type_name)