#!/usr/bin/env python3

""" URL configuration for the application """

from django.urls import path

from todo.views import (
    all_todo_items,
    toggle_todo_state,
    add_todo
)


urlpatterns = [
    path('todos/', all_todo_items, name='todos'),
    path('todos/<uuid:id>', toggle_todo_state, name='toggle'),
    path('todo/add', add_todo, name='new_todo')
    
]
