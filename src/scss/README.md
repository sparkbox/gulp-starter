# SCSS

## CSS

- When you are naming something, **do not** name it based on its content,
  unless you're applying specific, non-reusable styles. Exceptions can be made if
  the pieces you are developing are unlikely to be used elsewhere, such as in a
  header or footer.

- Name classes based on the function of their styles. A lot of the time,
  the function of a class is to change the presentation of something.
  Err on the side of naming things based on *presentation* rather than *content.*

- Only scope styles when necessary:

```css
/* avoid this: */
.sidebar .child {
  width: 50%;
}

/* better: */
.child_constrained {
  width: 50%;
}
```

## Naming Style

We follow [SMACSS](http://smacss.com/)-like conventions when naming CSS classes.

**Modules** are the building blocks of a website. Multi-word module names should be *hyphen-separated*:
```css
.module {}
/* or */
.special-list {}
```

**Subcomponents** are bits and pieces of a module that are specific to that module. A module is separated from a subcomponent with *double--hyphens*:
```css
.module--subcomponent {}
/* or */
.special-list--item {}
```

**Modifiers** change or add styling in certain cases. They should be separated from what they modify with *underscores*:
```css
.module--subcomponent_modifier {}
/* or */
.special-list--item_has-image {}
```

**Alternate modules** (a.k.a. subclassed modules) are simply modified modules. That means we use the modifier's *underscore* convention on them:
```css
.module_modifier {}
/* or */
.special-list_constrained {}
```

So if a subcomponent requires special styling inside of an alternate module, do this:
```css
.module_modifier--subcomponent {}
/* or */
.special-list_constrained--item { /* add me to an element in addition to .special-list--item */}
```

**Only be as verbose as you need to be.** Don't allude to DOM structure when you don't need to:
```css
/* don't do */
.special-list--contents--image {}

/* do */
.special-list--image {}
```
