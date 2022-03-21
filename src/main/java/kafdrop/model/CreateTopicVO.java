package kafdrop.model;

import lombok.Data;
import lombok.RequiredArgsConstructor;

@Data
@RequiredArgsConstructor
public final class CreateTopicVO {
  String name;

  int partitionsNumber;

  int replicationFactor;
}
