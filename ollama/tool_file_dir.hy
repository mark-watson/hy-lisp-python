(import os)

(defn list-directory []
  "Lists files and directories in the current working directory"
  ; Args:
  ;   None
  ; Returns:
  ;   string containing the current directory name, followed by list of files in the directory
  (try
    (setv current-dir (os.path.cwd))
    (setv files (list (.glob current-dir "*")))

    ; Convert Path objects to strings and sort
    (setv file-list (sorted [(.name (str f)) for f in files]))

    (setv file-list [file for file in file-list if (not (.endswith file "~"))])
    (setv file-list [file for file in file-list if (not (.startswith file "."))])

    (return (f "Contents of current directory {current-dir} is: [{(', '.join file-list)}]" ))
    (except [Error e]
      (return (f "Error listing directory: {(str e)}")))))


; Function metadata for Ollama integration (Hy doesn't have function metadata like Python)
; You might need to store this information separately or adapt it to your Ollama integration method.
; For example, you could create a dictionary mapping function names to their metadata.

(setv list-directory-metadata
  {
    "name" "list_directory"
    "description" "Lists files and directories in the current working directory"
    "parameters" {}
  })


