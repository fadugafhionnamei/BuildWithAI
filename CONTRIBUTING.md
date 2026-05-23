# Contributing to Elitech Nexus

Thank you for your interest in contributing to **Elitech Nexus**! This document provides guidelines for contributing to the project.

## Code of Conduct

- Be respectful to all contributors
- Maintain a welcoming and inclusive environment
- Focus on constructive feedback
- Report issues responsibly

## Getting Started

1. **Fork the repository** on GitHub
2. **Clone your fork** locally:
   ```bash
   git clone https://github.com/YOUR_USERNAME/BuildWithAI.git
   cd BuildWithAI
   ```

3. **Create a feature branch**:
   ```bash
   git checkout -b feature/your-feature-name
   ```

4. **Make your changes** following the code style guidelines

5. **Test your changes** thoroughly

6. **Commit with clear messages**:
   ```bash
   git commit -m "Add feature: brief description"
   ```

7. **Push to your fork**:
   ```bash
   git push origin feature/your-feature-name
   ```

8. **Submit a Pull Request** with a clear title and description

## Code Style

### JavaScript
- Use camelCase for variables and functions
- Use PascalCase for classes
- Add JSDoc comments for complex functions
- Maintain consistent indentation (2 spaces)
- Use `const` and `let`, avoid `var`

### HTML/CSS
- Use semantic HTML5 elements
- Follow Tailwind CSS naming conventions
- Keep CSS classes descriptive and lowercase
- Use meaningful IDs for interactive elements

## Commit Message Format

```
<type>: <short description>

<optional detailed description>
```

Types:
- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation update
- `style`: Code style change
- `refactor`: Code refactoring
- `perf`: Performance improvement
- `test`: Test additions/modifications
- `chore`: Build, dependencies, etc.

## Bug Reports

When reporting bugs, include:
- Description of the issue
- Steps to reproduce
- Expected vs actual behavior
- Screenshots (if applicable)
- Environment details (OS, browser, Node version)

## Feature Requests

When suggesting features:
- Clearly describe the feature
- Explain the use case
- Provide example or mockup if possible
- Consider backward compatibility

## Pull Request Guidelines

1. **One feature per PR** - Keep pull requests focused
2. **Clear description** - Explain what changes and why
3. **Test coverage** - Ensure changes are tested
4. **Documentation** - Update README if necessary
5. **Performance** - Consider optimization
6. **Accessibility** - Maintain WCAG standards

## Development Workflow

### Backend Development
```bash
cd backend
npm install
npm run dev
```

### Frontend Development
Use VS Code Live Server or Python HTTP server

### Database Changes
- Update `database/schema.sql`
- Document migration steps
- Provide rollback instructions

## Areas for Contribution

- Bug fixes
- Performance improvements
- UI/UX enhancements
- Documentation improvements
- Test coverage
- Feature development
- Translation support

## Questions?

- Check existing issues/discussions
- Review documentation
- Ask in pull request comments
- Contact maintainers directly

---

Thank you for contributing to Elitech Nexus!
