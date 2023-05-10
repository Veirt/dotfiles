local present, refactoring = pcall(require, "refactoring")

if not present then
    return
end

refactoring.setup()
