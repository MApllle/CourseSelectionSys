# Generated by Django 4.2.8 on 2024-01-03 15:00

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('managementApp', '0017_student_comments'),
    ]

    operations = [
        migrations.CreateModel(
            name='meeting_room',
            fields=[
                ('room_id', models.CharField(max_length=32, primary_key=True, serialize=False, unique=True)),
                ('room_name', models.CharField(default='A', max_length=32)),
                ('room_size', models.CharField(default='small', max_length=32)),
                ('min_number', models.IntegerField(default=2)),
                ('status', models.BooleanField(default=0)),
                ('time_range', models.CharField(blank=True, choices=[('8-12', '8-12'), ('13-17', '13-17'), ('18-22', '18-22')], default='8-12', max_length=32, null=True)),
            ],
            options={
                'db_table': 'managementapp_meeting_room',
            },
        ),
    ]
