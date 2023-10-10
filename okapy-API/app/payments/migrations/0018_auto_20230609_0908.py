# Generated by Django 3.2.15 on 2023-06-09 06:08

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('payments', '0017_auto_20230329_1107'),
    ]

    operations = [
        migrations.AlterField(
            model_name='order',
            name='status',
            field=models.CharField(choices=[('1', 'created'), ('2', 'confirmed'), ('3', 'picked'), ('4', 'transit'), ('5', 'arrived'), ('6', 'partner_created'), ('7', 'partner_confirmed'), ('8', 'rejected')], default=1, max_length=1),
        ),
        migrations.AlterField(
            model_name='payment',
            name='status',
            field=models.CharField(choices=[('1', 'created'), ('2', 'confirmed'), ('3', 'picked'), ('4', 'transit'), ('5', 'arrived'), ('6', 'partner_created'), ('7', 'partner_confirmed'), ('8', 'rejected')], default=1, max_length=1),
        ),
    ]
