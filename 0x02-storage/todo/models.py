#!/usr/bin/env python3

""" Models for the application """


from django.db import models
from uuid import uuid4


class Todo(models.Model):
    id = models.UUIDField(default=uuid4, primary_key=True)
    title = models.CharField(max_length=100)
    done = models.BooleanField(default=False)
    
    def __str__(self):
        return self.title
    