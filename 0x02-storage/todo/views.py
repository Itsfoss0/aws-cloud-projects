#!/usr/bin/env python3

# todo /views.py

""" View for the application """

from django.shortcuts import (
    render,
    redirect,
    reverse,
    get_object_or_404
)

from todo.models import Todo
from todo.forms import TodoForm


def all_todo_items(request):
    """List all todo items"""
    
    todos = Todo.objects.all()
    form = TodoForm()
    context = {
        "todos": todos,
        "form": form
    }
    return render(request, "todo/_all_todos.html", context=context)


def toggle_todo_state(request, id):
    """ togle the state of the item """
    todo = get_object_or_404(Todo, id=id)
    todo.done = not todo.done
    todo.save()
    
    return redirect(reverse("todos"))

def add_todo(request):
    if request.method == "POST":
        form = TodoForm(request.POST)
        if form.is_valid():
            form.save()
            return redirect(reverse("todos"))
