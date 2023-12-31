# Generated by Django 4.2.8 on 2023-12-17 15:20

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ("managementApp", "0002_rename_t_teacher"),
    ]

    operations = [
        migrations.AlterField(
            model_name="department",
            name="phone_code",
            field=models.CharField(blank=True, max_length=64, null=True),
        ),
        migrations.AlterField(
            model_name="student",
            name="date_of_birth",
            field=models.DateField(blank=True, null=True),
        ),
        migrations.AlterField(
            model_name="student",
            name="mobile_phone",
            field=models.CharField(blank=True, max_length=32, null=True, unique=True),
        ),
        migrations.AlterField(
            model_name="student",
            name="native_place",
            field=models.CharField(blank=True, max_length=32, null=True),
        ),
        migrations.AlterField(
            model_name="student",
            name="sex",
            field=models.CharField(blank=True, max_length=4, null=True),
        ),
        migrations.AlterField(
            model_name="teacher",
            name="date_of_birth",
            field=models.DateField(blank=True, null=True),
        ),
        migrations.AlterField(
            model_name="teacher",
            name="professional_ranks",
            field=models.CharField(blank=True, max_length=32, null=True),
        ),
        migrations.AlterField(
            model_name="teacher",
            name="salary",
            field=models.FloatField(blank=True, null=True),
        ),
        migrations.AlterField(
            model_name="teacher",
            name="sex",
            field=models.CharField(blank=True, max_length=4, null=True),
        ),
    ]
