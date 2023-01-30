from django.contrib import admin
from django.urls import include, path
from django.contrib.staticfiles.urls import staticfiles_urlpatterns
from hello.views import post_list, post_detail, post_new, post_edit, post_delete

urlpatterns = [
    path("", include("hello.urls")),
    path('admin/', admin.site.urls),
    path('post/', post_list, name='post_list'),
    path('post/<int:pk>/', post_detail, name='post_detail'),
    path('post/new/', post_new, name='post_new'),
    path('post/<int:pk>/edit/', post_edit, name='post_edit'),
    path('post/<int:pk>/delete/', post_delete, name='post_delete')
]

urlpatterns += staticfiles_urlpatterns()