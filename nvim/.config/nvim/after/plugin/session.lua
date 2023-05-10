local present, persisted = pcall(require, "persisted")

if not present then
    return
end

persisted.setup()
