#!/usr/bin/env python3

# todo/admin.py

from django.contrib import admin

from todo.models import Todo


admin.site.register(Todo)