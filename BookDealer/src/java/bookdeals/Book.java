package bookdeals;

import java.util.ArrayList;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/**
 *
 * @author rohlf
 */
public class Book {

    public String title, author, genre, description, isbn;
    public int year;

    public Book() {
        title = "";
        author = "";
        genre = "";
        description = "";
        year = 0;
        isbn = "";
    }

    public void setIsbn(String isbn) {
        this.isbn = isbn;
    }

    public String getIsbn() {
        return isbn;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

    public void setGenre(String genre) {
        this.genre = genre;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public void setYear(int year) {
        this.year = year;
    }

    public String getTitle() {
        return title;
    }

    public String getAuthor() {
        return author;
    }

    public String getGenre() {
        return genre;
    }

    public String getDescription() {
        return description;
    }

    public int getYear() {
        return year;
    }

    public static boolean containsBook(ArrayList<Book> wishList, String bookISBN) {
        for (Book book : wishList) {
            if (book.getIsbn().equals(bookISBN)) {
                return true;
            }
        }
        return false;
    }

}
