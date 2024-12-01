document.addEventListener("turbo:load", () => {
    const chatContainer = document.querySelector(".chats");
    if (chatContainer) {
      chatContainer.scrollTop = chatContainer.scrollHeight; // 最下部にスクロール
    }
  });
  