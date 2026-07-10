package org.example;

import org.junit.jupiter.api.Test;

import static org.mockito.Mockito.*;

public class MyServiceTest {

    @Test
    void testVerifyInteraction() {

        // Arrange
        ExternalApi mockApi = mock(ExternalApi.class);
        MyService service = new MyService(mockApi);

        // Act
        service.fetchData();

        // Assert
        verify(mockApi).getData();
    }
}