# Generated by Django 4.2.8 on 2023-12-23 14:04

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ("managementApp", "0009_alter_student_mobile_phone"),
    ]

    operations = [
        migrations.RenameField(
            model_name="student",
            old_name="total_cerdict",
            new_name="total_credit",
        ),
    ]