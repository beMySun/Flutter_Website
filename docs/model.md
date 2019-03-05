# connect a Component to model

```
  connectToModel() {
    return ScopedModelDescendant<GlobalModel>(
      builder: (context, child, model) {
        return Text(
          "${model.data.trackingList[0].timestamp}",
        );
      },
    );
  }
```