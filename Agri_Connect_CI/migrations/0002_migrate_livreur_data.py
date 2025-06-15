from django.db import migrations, models
import django.db.models.deletion

def migrate_data(apps, schema_editor):
    Livreur = apps.get_model('Agri_Connect_CI', 'Livreur')
    
    for livreur in Livreur.objects.all().select_related('utilisateur'):
        if livreur.utilisateur:
            Livreur.objects.filter(pk=livreur.pk).update(utilisateur_new=livreur.utilisateur)

def reverse_migrate_data(apps, schema_editor):
    Livreur = apps.get_model('Agri_Connect_CI', 'Livreur')
    Livreur.objects.all().update(utilisateur_new=None)

class Migration(migrations.Migration):

    dependencies = [
        ('Agri_Connect_CI', '0004_finalize_livreur_relation'),
    ]

    operations = [
        migrations.AddField(
            model_name='livreur',
            name='utilisateur_new',
            field=models.ForeignKey(
                to='Agri_Connect_CI.Utilisateur',
                null=True,
                on_delete=django.db.models.deletion.CASCADE,
            ),
        ),
        migrations.RunPython(
            migrate_data,
            reverse_code=reverse_migrate_data,
        ),
    ]
