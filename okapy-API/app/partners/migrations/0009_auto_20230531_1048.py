# Generated by Django 3.2.15 on 2023-05-31 07:48

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('partners', '0008_auto_20230524_1924'),
    ]

    operations = [
        migrations.CreateModel(
            name='ProductCategory',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('is_active', models.BooleanField(default=True)),
                ('is_deleted', models.BooleanField(default=False)),
                ('date_created', models.DateTimeField(auto_now_add=True)),
                ('date_deleted', models.DateTimeField(blank=True, null=True)),
                ('name', models.CharField(blank=True, max_length=207, null=True)),
                ('partner', models.ForeignKey(blank=True, default='', null=True, on_delete=django.db.models.deletion.CASCADE, to='partners.partner')),
            ],
            options={
                'verbose_name_plural': 'ProductCategories',
            },
        ),
        migrations.AddField(
            model_name='partnerproduct',
            name='category',
            field=models.ForeignKey(blank=True, default='', null=True, on_delete=django.db.models.deletion.CASCADE, to='partners.productcategory'),
        ),
    ]
