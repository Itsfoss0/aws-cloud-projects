#!/usr/bin/env python3

""" Forms for the application """


from django.forms import ModelForm
from todo.models import Todo

class TodoForm(ModelForm):
    
    class Meta:
        model = Todo
        fields = ("title",)
