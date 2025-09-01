import gleam/list
import gleam/regexp
import gleam/result
import gleam/string
import simplifile

pub fn read_emails(path: String) -> Result(List(String), Nil) {
  let assert Ok(re) =
    regexp.from_string("^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$")
  simplifile.read(path)
  |> result.map(string.split(_, "\n"))
  |> fn(emails) {
    case emails {
      Ok(email) ->
        email |> list.filter(fn(x) { x |> regexp.check(re, _) }) |> Ok
      Error(_) -> Error(Nil)
    }
  }
}

pub fn create_log_file(path: String) -> Result(Nil, Nil) {
  simplifile.write(path, "")
  |> fn(result) {
    case result {
      Ok(_) -> Ok(Nil)
      Error(_) -> Error(Nil)
    }
  }
}

pub fn log_sent_email(path: String, email: String) -> Result(Nil, Nil) {
  simplifile.append(path, email <> "\n")
  |> fn(result) {
    case result {
      Ok(_) -> Ok(Nil)
      Error(_) -> Error(Nil)
    }
  }
}

pub fn send_newsletter(
  emails_path: String,
  log_path: String,
  send_email: fn(String) -> Result(Nil, Nil),
) -> Result(Nil, Nil) {
  let assert Ok(_) = create_log_file(log_path)
  read_emails(emails_path)
  |> result.map(fn(emails) {
    emails
    |> list.fold(Ok(Nil), fn(_acc, email) {
      case send_email(email) {
        Ok(_) -> log_sent_email(log_path, email)
        Error(_) -> Error(Nil)
        // If sending fails, we just skip logging
      }
    })
  })
  |> fn(result) {
    case result {
      Ok(_) -> Ok(Nil)
      Error(_) -> Error(Nil)
    }
  }
}
