import QtQuick 2.0
import Sailfish.Silica 1.0
import QtQuick.LocalStorage 2.0

Item {
    property var db;

    Component.onCompleted: {
        db = LocalStorage.openDatabaseSync("notes", "1.0");
        create_notes_table();
    }

    function create_notes_table() {
        db.transaction(function(tx) {
            //tx.executeSql("DROP TABLE notes;");
            tx.executeSql("CREATE TABLE notes (
                id INTEGER PRIMARY KEY AUTOINCREMENT, "
                + "note TEXT NOT NULL);");
        });
    }

    function retrieve_notes(callback) {
        db.readTransaction(function(tx) {
            var result = tx.executeSql("SELECT * FROM notes;");
            callback(result.rows);
        });
    }

    function insert_note(note) {
        db.transaction(function(tx) {
            tx.executeSql("INSERT INTO notes (note) VALUES(?);", [note]);
        });
    }

    function delete_note(id) {
        db.transaction(function(tx) {
            tx.executeSql("DELETE FROM notes WHERE id = ?;", [id]);
        });
    }
}

