package in.vlrscript.interpreteur;

import in.vlrscript.parser.BiolLexer;
import org.antlr.v4.runtime.CharStreams;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;

public class Main {
    public static void main(String[] args) throws IOException {
        FileInputStream stream = null;
        BiolLexer vlrLexer = null;
        try {
            File file = new File("../resources/program.vlr");
            stream = new FileInputStream(file);
            vlrLexer = new BiolLexer(CharStreams.fromStream(stream)); // read your program input and create lexer instance
        } catch (FileNotFoundException e) {
            System.out.println("file not found '-'");
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            if (stream != null) {
                stream.close();
            }
        }
        fsdf
    }
}
