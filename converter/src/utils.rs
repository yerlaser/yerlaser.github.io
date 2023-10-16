use std::{collections::HashMap, path::Path};

mod argument_parser;
mod table_reader;

pub type Table = HashMap<String, String>;

pub struct FileNames {
    pub source: String,
    pub destination: String,
}

pub struct Utils {
    arguments: argument_parser::CliArgs,
    pub table: Table,
}

impl Utils {
    pub fn new() -> Self {
        Self {
            arguments: argument_parser::parse(),
            table: table_reader::read_table(),
        }
    }

    pub fn get_filenames(&self) -> Vec<FileNames> {
        let source_filenames = &self.arguments.source_filenames;

        source_filenames
            .iter()
            .map(|f| FileNames {
                source: self.check_source_file(&f).to_owned(),
                destination: self.check_destination_file(&f).to_owned(),
            })
            .collect::<Vec<FileNames>>()
    }

    fn check_source_file(&self, filename: &str) -> String {
        let path = Path::new(&filename);

        let path = if path.is_symlink() {
            path.read_link()
                .expect(&format!("Invalid source link: {filename}"))
                .as_path()
                .to_owned()
        } else {
            path.to_owned()
        };

        if !path.exists() || !path.is_file() {
            panic!("Source file does not exist: {filename}")
        };

        filename.to_owned()
    }

    fn check_destination_file(&self, filename: &str) -> String {
        let argument_parser::CliArgs {
            prefix,
            suffix,
            force,
            ..
        } = &self.arguments;
        let path = Path::new(&filename);
        let parent = path.parent().unwrap();
        let stem = path.file_stem().unwrap().to_str().unwrap();
        let ext = path.extension().unwrap().to_str().unwrap();

        let filename = parent
            .join(format!("{prefix}{stem}{suffix}.{ext}"))
            .to_str()
            .expect("Cannot not construct destination file name")
            .to_owned();

        let path = if path.is_symlink() {
            path.read_link()
                .expect(&format!("Invalid destination link: {filename}"))
                .as_path()
                .to_owned()
        } else {
            path.to_owned()
        };

        if (path.exists() && !force) || !path.is_file() {
            panic!("Destination file exists: {filename}\nUse force (if force was already used then the path cannot be overwritten)")
        };

        filename.to_owned()
    }
}
