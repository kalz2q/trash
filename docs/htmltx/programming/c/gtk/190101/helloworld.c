// https://en.wikipedia.org/wiki/GTK
// gcc -Wall `pkg-config --cflags gtk+-3.0` -o helloworld helloworld.c `pkg-config --libs gtk+-3.0`

#include <gtk/gtk.h>

int main (int argc, char **argv) {
  GtkWidget *w, *l;  // window, label;
  gtk_init(&argc, &argv);
  w = gtk_window_new(GTK_WINDOW_TOPLEVEL);
  gtk_window_set_title(GTK_WINDOW(w), "hello, world");
  gtk_window_set_position(GTK_WINDOW(w), GTK_WIN_POS_CENTER);
  gtk_window_set_default_size(GTK_WINDOW(w), 200, 100);
  g_signal_connect(w, "destroy", G_CALLBACK(gtk_main_quit), NULL);
  l = gtk_label_new("hello, world");
  gtk_container_add(GTK_CONTAINER(w), l);
  gtk_widget_show_all(w);
  gtk_main();
}
