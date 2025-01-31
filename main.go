package main

import (
	"html/template"
	"net/http"
)

func renderTemplate(w http.ResponseWriter, tmpl string) {
	tmplPath := "templates/" + tmpl + ".html"
	tmpl, err := template.ParseFiles(tmplPath)
	if err != nil {
		http.Error(w, "Error al cargar la página", http.StatusInternalServerError)
		return
	}
	tmpl.Execute(w, nil)
}

func homeHandler(w http.ResponseWriter, r *http.Request) {
	renderTemplate(w, "index")
}

func contactHandler(w http.ResponseWriter, r *http.Request) {
	renderTemplate(w, "contact")
}

func aboutHandler(w http.ResponseWriter, r *http.Request) {
	renderTemplate(w, "about")
}

func main() {
	http.HandleFunc("/", homeHandler)
	http.HandleFunc("/contact", contactHandler)
	http.HandleFunc("/about", aboutHandler)

	http.ListenAndServe(":8080", nil)
}

