# Generated by Django 4.2.8 on 2024-01-02 12:57

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ("managementApp", "0016_merge_20231230_1932"),
    ]

    operations = [
        migrations.CreateModel(
            name="student_comments",
            fields=[
                (
                    "id",
                    models.BigAutoField(
                        auto_created=True,
                        primary_key=True,
                        serialize=False,
                        verbose_name="ID",
                    ),
                ),
                ("comments", models.TextField()),
                (
                    "course_id",
                    models.ForeignKey(
                        on_delete=django.db.models.deletion.CASCADE,
                        to="managementApp.course",
                    ),
                ),
                (
                    "staff_id",
                    models.ForeignKey(
                        on_delete=django.db.models.deletion.CASCADE,
                        to="managementApp.teacher",
                    ),
                ),
                (
                    "student_id",
                    models.ForeignKey(
                        on_delete=django.db.models.deletion.CASCADE,
                        to="managementApp.student",
                    ),
                ),
            ],
        ),
    ]
