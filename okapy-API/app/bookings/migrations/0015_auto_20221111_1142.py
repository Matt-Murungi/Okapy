# Generated by Django 3.2.15 on 2022-11-11 08:42

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ("bookings", "0014_auto_20221111_1141"),
    ]

    operations = [
        migrations.AlterField(
            model_name="bookings",
            name="latitude",
            field=models.FloatField(),
        ),
        migrations.AlterField(
            model_name="bookings",
            name="longitude",
            field=models.FloatField(),
        ),
        migrations.AlterField(
            model_name="receiverdetails",
            name="latitude",
            field=models.FloatField(),
        ),
        migrations.AlterField(
            model_name="receiverdetails",
            name="longitude",
            field=models.FloatField(),
        ),
    ]
