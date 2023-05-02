# Silta CircleCI 

## CircleCI ORB

A collection of CircleCI tools used by the Silta hosting infrastructure.

## Usage

### Tagged releases

Tagged releases are published to the CircleCI registry. To use a specific version of the orb, add the following to your CircleCI config:

```yaml
orbs:
  silta: silta/silta@tagged_version
```

* Note 1:[View the latest version](https://circleci.com/developer/orbs/orb/silta/silta)
* Note 2: It's suggested to use minor tagged versions (e.g. `1.0`, see "Note 1" for correct version) instead of patch versions (e.g. `0.1.123`) to keep up with changes. Patch version can get outdated and break your builds as other components change (e.g. builder image if it's not pinned)

It's suggested to use tagged releases for Your builds, fixed to minor version (see "Note 2").

### Main branch

Master branch is automatically published to CircleCI registry. To use the latest version of the orb for early testing, add the following to your CircleCI config:

```yaml
orbs:
  silta: silta/silta@dev:master
```

Dev branch usage:

```yaml
orbs:
  silta: silta/silta@dev:branch_name
```

Use these to test special functionality.
