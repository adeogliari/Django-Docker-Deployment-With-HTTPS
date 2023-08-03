from django.db import models

# Create your models here.
class Sample(models.Model):
    attachment = models.FileField()