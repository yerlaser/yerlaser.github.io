use std::path::Path;

pub mod parseargs;

pub struct Utils {
    arguments: parseargs::Arguments,
}

impl Utils {
    pub fn new() -> Self {
        Utils {
            arguments: parseargs::parse(),
        }
    }

    pub fn get_filenames(&self) -> Vec<(String, String)> {
        let input_filenames = &self.arguments.input_filenames;

        input_filenames
            .iter()
            .map(|f| {
                (
                    self.check_input_file(&f).to_owned(),
                    self.check_output_file(&f).to_owned(),
                )
            })
            .collect::<Vec<(String, String)>>()
    }

    fn check_input_file(&self, filename: &str) -> String {
        let path = Path::new(&filename);

        let path = if path.is_symlink() {
            path.read_link()
                .expect(&format!("Invalid input link: {filename}"))
                .as_path()
                .to_owned()
        } else {
            path.to_owned()
        };

        if !path.exists() || !path.is_file() {
            panic!("File does not exist: {filename}")
        };

        filename.to_owned()
    }

    fn check_output_file(&self, input_filename: &str) -> String {
        let parseargs::Arguments {
            prefix,
            suffix,
            force,
            ..
        } = &self.arguments;
        let path = Path::new(&input_filename);
        let parent = path.parent().unwrap();
        let stem = path.file_stem().unwrap().to_str().unwrap();
        let ext = path.extension().unwrap().to_str().unwrap();

        let filename = parent
            .join(format!("{prefix}{stem}{suffix}.{ext}"))
            .to_str()
            .expect("Could not construct output file name")
            .to_owned();

        let path = if path.is_symlink() {
            path.read_link()
                .expect(&format!("Invalid input link: {filename}"))
                .as_path()
                .to_owned()
        } else {
            path.to_owned()
        };

        if (path.exists() && !force) || !path.is_file() {
            panic!("Output file exists: {filename}\nUse force (if force was already used then the path cannot be overwritten)")
        };

        filename.to_owned()
    }
}
