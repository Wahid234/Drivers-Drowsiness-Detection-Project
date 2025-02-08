

from django.urls import path
from .views import PredictListView,PredictListCreateView, PredictUpdateView,PredictDeleteView
urlpatterns = [
    path('', PredictListView.as_view()),
    path('list', PredictListView.as_view()),
    path('create', PredictListCreateView.as_view()),
    path('edit/<int:pk>', PredictUpdateView.as_view()),
    path('delete/<int:pk>', PredictDeleteView.as_view()),
]
