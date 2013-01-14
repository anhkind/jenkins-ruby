module RSpecHelpers
  def content(file_path)
    File.read(file_path)
  end

  def file(filename)
    File.join(SPEC_ROOT, "fixtures", "files", filename)
  end

  def vcr(name)
    VCR.use_cassette(name) do
      yield
    end
  end

  def options
    {
      host:     'localhost',
      port:     8080,
      username: 'username',
      password: 'password'
    }
  end
end