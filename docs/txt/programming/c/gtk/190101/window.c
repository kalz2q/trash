// http://uchigo.main.jp/gtk3/chap02/chap02.html
// 素人の独学GTK+3.0 - ウィンドウ表示
// gcc window.c $(pkg-config --cflags --libs gtk+-3.0)

#include <gtk/gtk.h>

int main(int argc, char **argv) {
  GtkWidget *w;  // window
  gtk_init(&argc, &argv);
  w = gtk_window_new(GTK_WINDOW_TOPLEVEL);
  gtk_widget_set_size_request(w, 300, 200);
  g_signal_connect(w, "destroy", G_CALLBACK(gtk_main_quit), NULL);
  gtk_widget_show(w);
  gtk_main();
}
